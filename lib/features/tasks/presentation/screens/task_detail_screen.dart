import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_providers.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final String? taskId; // Make this nullable

  const TaskDetailScreen({super.key, this.taskId});

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  bool _isEditing = false;
  String? _editingTaskId;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This is a bit hacky but it works to get the arguments
    if (_isInit) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final String? routeTaskId = args is String ? args : null;
      final String? idToLoad = widget.taskId ?? routeTaskId;

      if (idToLoad != null) {
        _isEditing = true;
        _editingTaskId = idToLoad;
        _loadTaskData(idToLoad);
      }
      _isInit = false;
    }
  }

  Future<void> _loadTaskData(String id) async {
    try {
      final task = await ref.read(getTaskByIdProvider(id)).call(id);
      if (mounted) {
        setState(() {
          _titleController.text = task.title;
          _descriptionController.text = task.description;
        });
      }
    } catch (e) {
      // Should probably log this somewhere
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load task: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(_isEditing ? 'Update Task' : 'Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (_isEditing && _editingTaskId != null) {
      // Update existing task
      await ref.read(taskNotifierProvider.notifier).updateTask(
            _editingTaskId!,
            title,
            description,
          );
    } else {
      // Create new task
      await ref.read(taskNotifierProvider.notifier).addTask(
            title,
            description,
          );
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }
}

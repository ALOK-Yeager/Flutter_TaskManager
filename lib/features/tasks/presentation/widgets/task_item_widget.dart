import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_providers.dart';

class TaskItemWidget extends ConsumerWidget {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const TaskItemWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: (value) {
            ref.read(taskNotifierProvider.notifier).toggleTaskStatus(id);
          },
        ),
        title: Text(
          title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: description.isNotEmpty ? Text(description) : null,
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              // Navigate to edit screen
              Navigator.pushNamed(
                context,
                '/task-detail',
                arguments: id,
              );
            } else if (value == 'delete') {
              ref.read(taskNotifierProvider.notifier).deleteTask(id);
            }
          },
        ),
      ),
    );
  }
}

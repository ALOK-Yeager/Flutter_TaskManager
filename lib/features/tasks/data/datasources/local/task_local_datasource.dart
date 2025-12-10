import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../core/database/hive_config.dart';
import '../../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getAllTasks();
  Future<TaskModel> getTaskById(String id);
  Future<void> saveTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<void> toggleTaskStatus(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final Box<TaskModel> _box;

  TaskLocalDataSourceImpl(this._box);

  factory TaskLocalDataSourceImpl.fromHive() {
    return TaskLocalDataSourceImpl(
      Hive.box<TaskModel>(HiveBoxes.tasks),
    );
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return _box.values.toList();
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    final task = _box.get(id);
    if (task == null) {
      throw Exception('Task with id $id not found');
    }
    return task;
  }

  @override
  Future<void> saveTask(TaskModel task) async {
    await _box.put(task.id, task);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    await _box.put(task.id, task.copyWith(updatedAt: DateTime.now()));
  }

  @override
  Future<void> deleteTask(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> toggleTaskStatus(String id) async {
    final task = await getTaskById(id);
    await _box.put(
        id,
        task.copyWith(
          isCompleted: !task.isCompleted,
          updatedAt: DateTime.now(),
        ));
  }
}

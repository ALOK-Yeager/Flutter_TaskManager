import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/local/task_local_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource _localDataSource;

  TaskRepositoryImpl(this._localDataSource);

  Task _modelToEntity(TaskModel model) {
    return Task(
      id: model.id,
      title: model.title,
      description: model.description,
      isCompleted: model.isCompleted,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  TaskModel _entityToModel(Task entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  Future<List<Task>> getAllTasks() async {
    final models = await _localDataSource.getAllTasks();
    return models.map(_modelToEntity).toList();
  }

  @override
  Future<Task> getTaskById(String id) async {
    final model = await _localDataSource.getTaskById(id);
    return _modelToEntity(model);
  }

  @override
  Future<void> saveTask(Task task) async {
    final model = _entityToModel(task);
    await _localDataSource.saveTask(model);
  }

  @override
  Future<void> updateTask(Task task) async {
    final model = _entityToModel(task);
    await _localDataSource.updateTask(model);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _localDataSource.deleteTask(id);
  }

  @override
  Future<void> toggleTaskStatus(String id) async {
    await _localDataSource.toggleTaskStatus(id);
  }
}

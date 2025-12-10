import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetAllTasks {
  final TaskRepository _repository;

  GetAllTasks(this._repository);

  Future<List<Task>> call() async {
    return await _repository.getAllTasks();
  }
}

class GetTaskById {
  final TaskRepository _repository;

  GetTaskById(this._repository);

  Future<Task> call(String id) async {
    return await _repository.getTaskById(id);
  }
}

class SaveTask {
  final TaskRepository _repository;

  SaveTask(this._repository);

  Future<void> call(Task task) async {
    await _repository.saveTask(task);
  }
}

class UpdateTask {
  final TaskRepository _repository;

  UpdateTask(this._repository);

  Future<void> call(Task task) async {
    await _repository.updateTask(task);
  }
}

class DeleteTask {
  final TaskRepository _repository;

  DeleteTask(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteTask(id);
  }
}

class ToggleTaskStatus {
  final TaskRepository _repository;

  ToggleTaskStatus(this._repository);

  Future<void> call(String id) async {
    await _repository.toggleTaskStatus(id);
  }
}

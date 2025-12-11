import '../../domain/entities/task.dart';
import '../repositories/task_repository_impl.dart';

class TaskService {
  final TaskRepositoryImpl repository;

  TaskService(this.repository);

  Future<List<Task>> getTasks() async {
    return await repository.getAllTasks();
  }

  Future<Task?> getTask(String id) async {
    return await repository.getTaskById(id);
  }

  Future<void> addTask(Task task) async {
    await repository.saveTask(task);
  }

  Future<void> modifyTask(Task task) async {
    await repository.updateTask(task);
  }

  Future<void> removeTask(String id) async {
    await repository.deleteTask(id);
  }

  // Future<void> synchronizeTasks() async {
  //   await repository.syncTasks();
  // }
}

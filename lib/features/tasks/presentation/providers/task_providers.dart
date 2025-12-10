import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/datasources/local/task_local_datasource.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/usecases/task_usecases.dart';
import '../../domain/entities/task.dart';

final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>(
  (ref) => TaskLocalDataSourceImpl.fromHive(),
);

final taskRepositoryProvider = Provider<TaskRepositoryImpl>(
  (ref) => TaskRepositoryImpl(ref.read(taskLocalDataSourceProvider)),
);

final getAllTasksProvider =
    Provider((ref) => GetAllTasks(ref.read(taskRepositoryProvider)));

final getTaskByIdProvider = Provider.family(
    (ref, String id) => GetTaskById(ref.read(taskRepositoryProvider)));

final saveTaskProvider =
    Provider((ref) => SaveTask(ref.read(taskRepositoryProvider)));

final updateTaskProvider =
    Provider((ref) => UpdateTask(ref.read(taskRepositoryProvider)));

final deleteTaskProvider =
    Provider((ref) => DeleteTask(ref.read(taskRepositoryProvider)));

final toggleTaskStatusProvider =
    Provider((ref) => ToggleTaskStatus(ref.read(taskRepositoryProvider)));

final tasksListProvider = FutureProvider<List<Task>>((ref) async {
  final usecase = ref.read(getAllTasksProvider);
  return await usecase();
});

final taskDetailProvider = FutureProvider.family<Task, String>((ref, id) async {
  final usecase = ref.read(getTaskByIdProvider(id));
  return await usecase(id);
});

final taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, AsyncValue<List<Task>>>(
  (ref) => TaskNotifier(ref),
);

class TaskNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  final Ref _ref;

  TaskNotifier(this._ref) : super(const AsyncValue.loading()) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    state = const AsyncValue.loading();
    try {
      final tasks = await _ref.read(getAllTasksProvider)();
      state = AsyncValue.data(tasks);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> addTask(String title, String description) async {
    final newTask = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      isCompleted: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _ref.read(saveTaskProvider)(newTask);
    _loadTasks(); // Refresh the list
  }

  Future<void> updateTask(String id, String title, String description) async {
    final existingTasks = await _ref.read(getAllTasksProvider)();
    final task = existingTasks.firstWhere((task) => task.id == id);
    final updatedTask = task.copyWith(
      title: title,
      description: description,
      updatedAt: DateTime.now(),
    );
    await _ref.read(updateTaskProvider)(updatedTask);
    _loadTasks(); // Refresh the list
  }

  Future<void> deleteTask(String id) async {
    await _ref.read(deleteTaskProvider)(id);
    _loadTasks(); // Refresh the list
  }

  Future<void> toggleTaskStatus(String id) async {
    await _ref.read(toggleTaskStatusProvider)(id);
    _loadTasks(); // Refresh the list
  }
}

import 'package:dio/dio.dart';
import '../../../../../core/network/api_client.dart';
import '../../models/task_model.dart';

class TaskRemoteDatasource {
  final ApiClient apiClient;

  TaskRemoteDatasource(this.apiClient);

  Future<List<TaskModel>> fetchTasks() async {
    try {
      final response = await apiClient.get('/tasks');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch tasks: ${e.message}');
    }
  }

  Future<TaskModel> fetchTaskById(String id) async {
    try {
      final response = await apiClient.get('/tasks/$id');
      return TaskModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to fetch task: ${e.message}');
    }
  }

  Future<void> createTask(TaskModel task) async {
    try {
      await apiClient.post('/tasks', data: task.toJson());
    } on DioException catch (e) {
      throw Exception('Failed to create task: ${e.message}');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await apiClient.put('/tasks/${task.id}', data: task.toJson());
    } on DioException catch (e) {
      throw Exception('Failed to update task: ${e.message}');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await apiClient.delete('/tasks/$id');
    } on DioException catch (e) {
      throw Exception('Failed to delete task: ${e.message}');
    }
  }
}

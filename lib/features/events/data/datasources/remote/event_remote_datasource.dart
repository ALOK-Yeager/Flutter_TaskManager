import 'package:dio/dio.dart';
import '../../../../../core/network/api_client.dart';
import '../../models/event_model.dart';

class EventRemoteDatasource {
  final ApiClient apiClient;

  EventRemoteDatasource(this.apiClient);

  Future<List<EventModel>> fetchEvents() async {
    try {
      final response = await apiClient.get('/events');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => EventModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch events: ${e.message}');
    }
  }

  Future<EventModel> fetchEventById(String id) async {
    try {
      final response = await apiClient.get('/events/$id');
      return EventModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Failed to fetch event: ${e.message}');
    }
  }

  Future<void> createEvent(EventModel event) async {
    try {
      await apiClient.post('/events', data: event.toJson());
    } on DioException catch (e) {
      throw Exception('Failed to create event: ${e.message}');
    }
  }

  Future<void> updateEvent(EventModel event) async {
    try {
      await apiClient.put('/events/${event.id}', data: event.toJson());
    } on DioException catch (e) {
      throw Exception('Failed to update event: ${e.message}');
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await apiClient.delete('/events/$id');
    } on DioException catch (e) {
      throw Exception('Failed to delete event: ${e.message}');
    }
  }
}

import '../../domain/entities/event.dart';
import '../repositories/event_repository_impl.dart';

class EventService {
  final EventRepositoryImpl repository;

  EventService(this.repository);

  Future<List<Event>> getEvents() async {
    return await repository.getAllEvents();
  }

  Future<Event?> getEvent(String id) async {
    return await repository.getEventById(id);
  }

  Future<void> addEvent(Event event) async {
    await repository.saveEvent(event);
  }

  Future<void> modifyEvent(Event event) async {
    await repository.updateEvent(event);
  }

  Future<void> removeEvent(String id) async {
    await repository.deleteEvent(id);
  }

  // Future<void> synchronizeEvents() async {
  //   await repository.syncEvents();
  // }
}

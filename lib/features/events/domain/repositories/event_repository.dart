import '../entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getAllEvents();
  Future<Event> getEventById(String id);
  Future<void> saveEvent(Event event);
  Future<void> updateEvent(Event event);
  Future<void> deleteEvent(String id);
}

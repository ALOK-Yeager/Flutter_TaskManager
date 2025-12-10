import '../entities/event.dart';
import '../repositories/event_repository.dart';

class GetAllEvents {
  final EventRepository _repository;

  GetAllEvents(this._repository);

  Future<List<Event>> call() async {
    return await _repository.getAllEvents();
  }
}

class GetEventById {
  final EventRepository _repository;

  GetEventById(this._repository);

  Future<Event> call(String id) async {
    return await _repository.getEventById(id);
  }
}

class SaveEvent {
  final EventRepository _repository;

  SaveEvent(this._repository);

  Future<void> call(Event event) async {
    await _repository.saveEvent(event);
  }
}

class UpdateEvent {
  final EventRepository _repository;

  UpdateEvent(this._repository);

  Future<void> call(Event event) async {
    await _repository.updateEvent(event);
  }
}

class DeleteEvent {
  final EventRepository _repository;

  DeleteEvent(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteEvent(id);
  }
}

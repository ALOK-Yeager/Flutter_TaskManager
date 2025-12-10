import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/local/event_local_datasource.dart';
import '../models/event_model.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource _localDataSource;

  EventRepositoryImpl(this._localDataSource);

  Event _modelToEntity(EventModel model) {
    return Event(
      id: model.id,
      title: model.title,
      dateTime: model.dateTime,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  EventModel _entityToModel(Event entity) {
    return EventModel(
      id: entity.id,
      title: entity.title,
      dateTime: entity.dateTime,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  Future<List<Event>> getAllEvents() async {
    final models = await _localDataSource.getAllEvents();
    return models.map(_modelToEntity).toList();
  }

  @override
  Future<Event> getEventById(String id) async {
    final model = await _localDataSource.getEventById(id);
    return _modelToEntity(model);
  }

  @override
  Future<void> saveEvent(Event event) async {
    final model = _entityToModel(event);
    await _localDataSource.saveEvent(model);
  }

  @override
  Future<void> updateEvent(Event event) async {
    final model = _entityToModel(event);
    await _localDataSource.updateEvent(model);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await _localDataSource.deleteEvent(id);
  }
}

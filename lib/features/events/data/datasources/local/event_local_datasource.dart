import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../core/database/hive_config.dart';
import '../../models/event_model.dart';

abstract class EventLocalDataSource {
  Future<List<EventModel>> getAllEvents();
  Future<EventModel> getEventById(String id);
  Future<void> saveEvent(EventModel event);
  Future<void> updateEvent(EventModel event);
  Future<void> deleteEvent(String id);
}

class EventLocalDataSourceImpl implements EventLocalDataSource {
  final Box<EventModel> _box;

  EventLocalDataSourceImpl(this._box);

  factory EventLocalDataSourceImpl.fromHive() {
    return EventLocalDataSourceImpl(
      Hive.box<EventModel>(HiveBoxes.events),
    );
  }

  @override
  Future<List<EventModel>> getAllEvents() async {
    return _box.values.toList();
  }

  @override
  Future<EventModel> getEventById(String id) async {
    final event = _box.get(id);
    if (event == null) {
      throw Exception('Event with id $id not found');
    }
    return event;
  }

  @override
  Future<void> saveEvent(EventModel event) async {
    await _box.put(event.id, event);
  }

  @override
  Future<void> updateEvent(EventModel event) async {
    await _box.put(event.id, event.copyWith(updatedAt: DateTime.now()));
  }

  @override
  Future<void> deleteEvent(String id) async {
    await _box.delete(id);
  }
}

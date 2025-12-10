import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/datasources/local/event_local_datasource.dart';
import '../../data/repositories/event_repository_impl.dart';
import '../../domain/usecases/event_usecases.dart';
import '../../domain/entities/event.dart';

final eventLocalDataSourceProvider = Provider<EventLocalDataSource>(
  (ref) => EventLocalDataSourceImpl.fromHive(),
);

final eventRepositoryProvider = Provider<EventRepositoryImpl>(
  (ref) => EventRepositoryImpl(ref.read(eventLocalDataSourceProvider)),
);

final getAllEventsProvider =
    Provider((ref) => GetAllEvents(ref.read(eventRepositoryProvider)));

final getEventByIdProvider = Provider.family(
    (ref, String id) => GetEventById(ref.read(eventRepositoryProvider)));

final saveEventProvider =
    Provider((ref) => SaveEvent(ref.read(eventRepositoryProvider)));

final updateEventProvider =
    Provider((ref) => UpdateEvent(ref.read(eventRepositoryProvider)));

final deleteEventProvider =
    Provider((ref) => DeleteEvent(ref.read(eventRepositoryProvider)));

final eventsListProvider = FutureProvider<List<Event>>((ref) async {
  final usecase = ref.read(getAllEventsProvider);
  return await usecase();
});

final eventDetailProvider =
    FutureProvider.family<Event, String>((ref, id) async {
  final usecase = ref.read(getEventByIdProvider(id));
  return await usecase(id);
});

final eventNotifierProvider =
    StateNotifierProvider<EventNotifier, AsyncValue<List<Event>>>(
  (ref) => EventNotifier(ref),
);

class EventNotifier extends StateNotifier<AsyncValue<List<Event>>> {
  final Ref _ref;

  EventNotifier(this._ref) : super(const AsyncValue.loading()) {
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    state = const AsyncValue.loading();
    try {
      final events = await _ref.read(getAllEventsProvider)();
      state = AsyncValue.data(events);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> addEvent(String title, DateTime dateTime) async {
    final newEvent = Event(
      id: const Uuid().v4(),
      title: title,
      dateTime: dateTime,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _ref.read(saveEventProvider)(newEvent);
    _loadEvents(); // Refresh the list
  }

  Future<void> updateEvent(String id, String title, DateTime dateTime) async {
    final existingEvents = await _ref.read(getAllEventsProvider)();
    final event = existingEvents.firstWhere((event) => event.id == id);
    final updatedEvent = event.copyWith(
      title: title,
      dateTime: dateTime,
      updatedAt: DateTime.now(),
    );
    await _ref.read(updateEventProvider)(updatedEvent);
    _loadEvents(); // Refresh the list
  }

  Future<void> deleteEvent(String id) async {
    await _ref.read(deleteEventProvider)(id);
    _loadEvents(); // Refresh the list
  }
}

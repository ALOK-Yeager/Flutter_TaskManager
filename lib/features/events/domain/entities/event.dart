import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required DateTime dateTime,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Event;

  factory Event.empty() => Event(
        id: '',
        title: '',
        dateTime: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

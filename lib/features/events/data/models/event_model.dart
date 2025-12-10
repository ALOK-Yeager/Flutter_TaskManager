import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'event_model.g.dart';
part 'event_model.freezed.dart';

@freezed
class EventModel with _$EventModel {
  @HiveType(typeId: 1)
  const factory EventModel({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required DateTime dateTime,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) required DateTime updatedAt,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  factory EventModel.empty() => EventModel(
        id: const Uuid().v4(),
        title: '',
        dateTime: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

// Hive adapter
class EventAdapter extends TypeAdapter<EventModel> {
  @override
  final int typeId = 1;

  @override
  EventModel read(BinaryReader reader) {
    return EventModel(
      id: reader.readString(),
      title: reader.readString(),
      dateTime: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeInt(obj.dateTime.millisecondsSinceEpoch);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeInt(obj.updatedAt.millisecondsSinceEpoch);
  }
}

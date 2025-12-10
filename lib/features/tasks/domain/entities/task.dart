import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Task;

  factory Task.empty() => Task(
        id: '',
        title: '',
        description: '',
        isCompleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String description,
    required bool
        isCompleted, // considered naming this isDone, but isCompleted sounds more professional
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Task;

  // Useful for initial states or when we need a placeholder
  factory Task.empty() => Task(
        id: '',
        title: '',
        description: '',
        isCompleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

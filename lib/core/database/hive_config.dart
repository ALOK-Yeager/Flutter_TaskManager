import 'package:hive_flutter/hive_flutter.dart';
import '../../features/tasks/data/models/task_model.dart';
import '../../features/events/data/models/event_model.dart';

class HiveConfig {
  // Using Hive because it's super fast and local-first.
  // Don't need a full SQL setup for this simple app.
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters - gotta do this before opening boxes or it crashes
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(EventAdapter());

    // Open boxes
    // TODO: Might need to handle migration if we change the model later
    await Hive.openBox<TaskModel>(HiveBoxes.tasks);
    await Hive.openBox<EventModel>(HiveBoxes.events);
  }
}

class HiveBoxes {
  // Simple box names, nothing fancy
  static const String tasks = 'tasks_box';
  static const String events = 'events_box';
}

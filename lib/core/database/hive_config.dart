import 'package:hive_flutter/hive_flutter.dart';
import '../../features/tasks/data/models/task_model.dart';
import '../../features/events/data/models/event_model.dart';

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(EventAdapter());

    // Open boxes
    await Hive.openBox<TaskModel>(HiveBoxes.tasks);
    await Hive.openBox<EventModel>(HiveBoxes.events);
  }
}

class HiveBoxes {
  static const String tasks = 'tasks_box';
  static const String events = 'events_box';
}

import 'package:hive_flutter/hive_flutter.dart';
import 'hive_config.dart';
import '../../features/tasks/data/models/task_model.dart';
import '../../features/events/data/models/event_model.dart';

class HiveBoxHelper {
  static Box<TaskModel> get taskBox => Hive.box<TaskModel>(HiveBoxes.tasks);
  static Box<EventModel> get eventBox => Hive.box<EventModel>(HiveBoxes.events);
}

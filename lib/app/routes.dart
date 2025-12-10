import 'package:flutter/material.dart';
import '../features/tasks/presentation/screens/task_list_screen.dart';
import '../features/tasks/presentation/screens/task_detail_screen.dart';
import '../features/events/presentation/screens/event_list_screen.dart';
import '../features/events/presentation/screens/event_detail_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String taskList = '/tasks';
  static const String taskDetail = '/tasks/detail';
  static const String eventList = '/events';
  static const String eventDetail = '/events/detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
      case taskList:
        return MaterialPageRoute(builder: (_) => const TaskListScreen());
      case taskDetail:
        return MaterialPageRoute(builder: (_) => const TaskDetailScreen());
      case eventList:
        return MaterialPageRoute(builder: (_) => const EventListScreen());
      case eventDetail:
        return MaterialPageRoute(builder: (_) => const EventDetailScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

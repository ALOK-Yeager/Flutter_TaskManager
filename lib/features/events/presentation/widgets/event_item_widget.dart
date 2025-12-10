import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/event_providers.dart';

class EventItemWidget extends ConsumerWidget {
  final String id;
  final String title;
  final DateTime dateTime;

  const EventItemWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedDateTime =
        DateFormat('MMM dd, yyyy - hh:mm a').format(dateTime);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(formattedDateTime),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              // Navigate to edit screen
              Navigator.pushNamed(
                context,
                '/event-detail',
                arguments: id,
              );
            } else if (value == 'delete') {
              ref.read(eventNotifierProvider.notifier).deleteEvent(id);
            }
          },
        ),
      ),
    );
  }
}

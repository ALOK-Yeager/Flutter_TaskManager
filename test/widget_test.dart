import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_event_manager/app/app.dart';

void main() {
  // Basic smoke test to make sure the app at least boots up
  testWidgets('App loads and shows Tasks screen', (WidgetTester tester) async {
    // Need to wrap in ProviderScope because we're using Riverpod
    // forgot this the first time and it crashed lol
    await tester.pumpWidget(
      const ProviderScope(
        child: TaskEventManagerApp(),
      ),
    );

    // Let the animations settle
    await tester.pumpAndSettle();

    // Just checking if the main title exists for now
    // TODO: Add more specific tests for adding tasks later
    expect(find.text('Tasks'), findsOneWidget);

    // Make sure we aren't showing the events screen by default
    expect(find.text('No events yet'), findsNothing);
  });
}

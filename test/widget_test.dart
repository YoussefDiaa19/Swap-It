import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swap_it/main.dart';

void main() {
  testWidgets('SwapIt app launches and navigation switches tabs', (WidgetTester tester) async {
    // Build the SwapIt application
    await tester.pumpWidget(const SwapItApp());
    await tester.pumpAndSettle();

    // Verify initial Home screen tab is visible
    expect(find.text('SwapIt'), findsOneWidget);
    expect(find.text('Home Feed - Items for Swap'), findsOneWidget);

    // Verify all 4 navigation destinations exist
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('My Profile'), findsOneWidget);

    // Tap the Chat tab
    await tester.tap(find.text('Chat'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Messages'), findsOneWidget);
    expect(find.text('Chats List'), findsOneWidget);

    // Tap the Favorites tab
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Favorites'), findsOneWidget);
    expect(find.text('Saved Items'), findsOneWidget);

    // Tap the My Profile tab
    await tester.tap(find.text('My Profile'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'My Profile'), findsOneWidget);
    expect(find.text('Alex Morgan'), findsWidgets);
    expect(find.text('My Listed Items'), findsOneWidget);

    // Open Profile endDrawer by tapping the menu icon
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify endDrawer items are rendered
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Terms & Conditions'), findsOneWidget);
    expect(find.text('Help & Support'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);

    // Tap a drawer item (e.g. Settings) and verify dialog opens
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Settings placeholder.\nThe team member can implement the detailed screen for this option.'), findsOneWidget);

    // Dismiss dialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });
}

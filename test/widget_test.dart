import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swap_it/main.dart';

void main() {
  testWidgets('SwapIt app launches with home feed, nav tabs, and item details navigation',
      (WidgetTester tester) async {
    // Set standard mobile screen dimensions
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Build the SwapIt application
    await tester.pumpWidget(const SwapItApp());
    await tester.pumpAndSettle();

    // Verify initial Home screen elements
    expect(find.text('SwapIt'), findsOneWidget);
    expect(find.text('SWAPIT'), findsOneWidget);
    expect(find.text('38 ITEMS LISTED TODAY'), findsOneWidget);
    expect(find.text('Recent Drops'), findsOneWidget);

    // Verify navigation tabs
    expect(find.text('HOME'), findsOneWidget);
    expect(find.text('CHAT'), findsOneWidget);
    expect(find.text('FAVORITES'), findsOneWidget);
    expect(find.text('PROFILE'), findsOneWidget);

    // Verify item cards rendered in grid
    expect(find.text('Leica M6...'), findsOneWidget);
    expect(find.text('Margiela Tabi (EU 42)'), findsOneWidget);

    // Tap on Leica M6 to navigate to Item Details
    await tester.tap(find.text('Leica M6...'));
    await tester.pumpAndSettle();

    // Verify Item Details screen loaded
    expect(find.text('Item Details'), findsOneWidget);
    expect(find.text('Leica M6 0.72x Black Chrome'), findsOneWidget);
    expect(find.text('MINT CONDITION'), findsOneWidget);
    expect(find.text('LOOKING TO SWAP FOR:'), findsOneWidget);
    expect(find.text('Sony A7 IV body'), findsOneWidget);
    expect(find.text('Fujifilm X100V or X100VI'), findsOneWidget);
    expect(find.text('35mm Summicron-M Lens'), findsOneWidget);
    expect(find.text('Propose a Swap'), findsOneWidget);

    // Tap "Propose a Swap" to open proposal bottom sheet
    await tester.tap(find.text('Propose a Swap'));
    await tester.pumpAndSettle();
    expect(find.text('Choose from "My Listed Items"'), findsOneWidget);

    // Close bottom sheet
    await tester.tap(find.text('Continue with Proposal'));
    await tester.pumpAndSettle();

    // Back to home
    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Recent Drops'), findsOneWidget);

    // Switch to CHAT tab
    await tester.tap(find.text('CHAT'));
    await tester.pumpAndSettle();
    expect(find.text('Messages'), findsOneWidget);

    // Switch to FAVORITES tab
    await tester.tap(find.text('FAVORITES'));
    await tester.pumpAndSettle();
    expect(find.text('Favorites'), findsOneWidget);

    // Switch to PROFILE tab
    await tester.tap(find.text('PROFILE'));
    await tester.pumpAndSettle();
    expect(find.text('Alex Morgan'), findsWidgets);
  });
}

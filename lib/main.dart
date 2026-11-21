import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/main_nav_wrapper.dart';

void main() {
  runApp(const SwapItApp());
}

/// Root widget for the SwapIt application.
///
/// Configures Material 3 light theme and launches [MainNavWrapper]
/// as the primary persistent navigation shell.
class SwapItApp extends StatelessWidget {
  const SwapItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwapIt',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavWrapper(),
    );
  }
}

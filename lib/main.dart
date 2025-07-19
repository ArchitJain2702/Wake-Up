import 'package:flutter/material.dart';
import 'package:wakeup/screens/stopwatch/StopWatchScreen.dart';

void main() {
  runApp(const ClockApp());
}

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock App',
      debugShowCheckedModeBanner: false,
      home: const StopwatchScreen(),
    );
  }
}

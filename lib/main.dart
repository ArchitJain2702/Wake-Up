import 'package:flutter/material.dart';
import 'package:wakeup/screens/firstsplash/firstsplash.dart';
import 'package:wakeup/screens/stopwatch/StopWatchScreen.dart';
import 'package:wakeup/screens/timer/maintimerpage.dart';
import 'package:wakeup/screens/timer/runningtimer.dart';
import 'package:wakeup/screens/timer/settimer.dart';
import 'package:wakeup/screens/universaltime/universaltime.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const ClockApp());
}

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock App',
      debugShowCheckedModeBanner: false,
      home: CustomTimerScreen(timerName: 'timerName', hours: 1, minutes: 13, seconds: 45),
    );
  }
}

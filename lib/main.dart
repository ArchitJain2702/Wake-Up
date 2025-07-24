import 'package:flutter/material.dart';
import 'package:wakeup/screens/alarm/alarmlistscreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:alarm/alarm.dart';

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init(); 
  
  runApp(const ClockApp());
}

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock App',
      debugShowCheckedModeBanner: false,
      home: AlarmListScreen(),
    );
  }
}

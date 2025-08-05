import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wakeup/screens/alarm/alarmlistscreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:alarm/alarm.dart';
import 'package:wakeup/screens/alarm/editalar.dart';
import 'package:wakeup/screens/alarm/setalarm.dart';
import 'package:wakeup/screens/stopwatch/StopWatchScreen.dart';
import 'package:wakeup/screens/tasks/maths.dart';
import 'package:wakeup/screens/tasks/typing.dart';

final FlutterLocalNotificationsPlugin flutterlocalnotificationplugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      navigatorKey: navigatorKey,
      home: AlarmHomeWrapper(),
    );
  }
}

class AlarmHomeWrapper extends StatefulWidget {
  @override
  State<AlarmHomeWrapper> createState() => AlarmHomeWrapperState();
}

class AlarmHomeWrapperState extends State<AlarmHomeWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add observer
    _checkForRingingAlarm(); // Don't use 'await' here, and don't make initState async
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Clean up
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkForRingingAlarm(); // When app resumes, check again
    }
  }

  Future<void> _checkForRingingAlarm() async {
    final ringing = await Alarm.isRinging();
    if (ringing == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                SentenceTypingChallengeScreen(totalQuestions: 2),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SentenceTypingChallengeScreen(totalQuestions: 2);
  }
}

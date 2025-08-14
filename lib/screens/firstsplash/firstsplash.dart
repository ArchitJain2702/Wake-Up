import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wakeup/screens/alarm/alarmlistscreen.dart';
import 'package:wakeup/screens/stopwatch/StopWatchScreen.dart';

class Firstsplash extends StatefulWidget {
  const Firstsplash({super.key});

  @override
  State<Firstsplash> createState() => _FirstsplashState();
}

class _FirstsplashState extends State<Firstsplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 9100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AlarmListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Text(
            'RiseWise',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}

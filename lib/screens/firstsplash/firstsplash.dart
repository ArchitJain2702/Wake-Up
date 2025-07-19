import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Future.delayed(const Duration(milliseconds: 1100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StopwatchScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 250,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WakeUp',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 23),
                Text(
                  'Great Days Begin  with\n     Great Mornings',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

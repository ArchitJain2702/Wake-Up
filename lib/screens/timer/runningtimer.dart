import 'package:flutter/material.dart';
import 'package:wakeup/widgets/bottombar.dart';
import 'dart:async';

import 'package:wakeup/widgets/header.dart';

class CustomTimerScreen extends StatefulWidget {
  final String timerName;
  final int hours;
  final int minutes;
  final int seconds;

  const CustomTimerScreen({
    Key? key,
    required this.timerName,
    required this.hours,
    required this.minutes,
    required this.seconds,
  }) : super(key: key);

  @override
  State<CustomTimerScreen> createState() => CustomTimerScreenState();
}

class CustomTimerScreenState extends State<CustomTimerScreen> {
  late int totalSeconds;
  Timer? _timer;
  bool isRunning = false;

  void startTimer() {
    if (isRunning) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (totalSeconds == 0) {
        _timer?.cancel();
      } else {
        setState(() {
          totalSeconds--;
        });
      }
    });
    setState(() {
      isRunning = true;
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      totalSeconds = widget.hours * 3600 + widget.minutes * 60 + widget.seconds;
      isRunning = false;
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    Navigator.of(context).pop(); // go back
  }

  String formatTime(int seconds) {
    final h = (seconds ~/ 3600).toString().padLeft(2, '0');
    final m = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  @override
  void initState() {
    super.initState();
    totalSeconds = widget.hours * 3600 + widget.minutes * 60 + widget.seconds;
  }

  @override
  Widget build(BuildContext context) {
    final h = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final m = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(60), child: Header(title: widget.timerName)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 62),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                timeBox(h, "Hours"),
                timeBox(m, "Minutes"),
                timeBox(s, "Seconds"),
              ],
            ),
            const SizedBox(height: 140),
            actionButton(isRunning ? "Pause" : "Start", isRunning ? pauseTimer : startTimer, Colors.blue.shade200),
            const SizedBox(height: 12),
            actionButton("Reset", resetTimer, Colors.grey.shade200),
            const SizedBox(height: 12),
            actionButton("Cancel", cancelTimer, Colors.grey.shade200),
          ],
        ),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }

  Widget timeBox(String time, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            time,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget actionButton(String text, VoidCallback onPressed, Color color) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wakeup/widgets/bottombar.dart';
import 'package:wakeup/widgets/header.dart';

enum StopwatchState { initial, running, paused }

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchState {
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  StopwatchState state = StopwatchState.initial;
  String formattedTime = "00:00:00";

  String format(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = (d.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');
    return "$minutes:$seconds:$milliseconds";
  }

  void updateTime(Function(String) onTick) {
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (stopwatch.isRunning) {
        onTick(format(stopwatch.elapsed));
      }
    });
  }

  void start(Function(String) onTick) {
    stopwatch.start();
    state = StopwatchState.running;
    updateTime(onTick);
  }

  void stop() {
    stopwatch.stop();
    state = StopwatchState.paused;
  }

  void resume(Function(String) onTick) {
    stopwatch.start();
    state = StopwatchState.running;
    updateTime(onTick);
  }

  void reset(Function(String) onReset) {
    stopwatch.reset();
    state = StopwatchState.initial;
    onReset("00:00:00");
    timer?.cancel();
  }

  void dispose() {
    timer?.cancel();
  }
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final _logic = _StopwatchState();

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  void _updateFormattedTime(String time) {
    setState(() {
      _logic.formattedTime = time;
    });
  }

  Widget _buildButtons(BuildContext context) {
    switch (_logic.state) {
      case StopwatchState.initial:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _logic.start(_updateFormattedTime);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                minimumSize: const Size(80, 80), // Bigger circle
              ),
              child: Icon(
                Icons.play_arrow,
                size: 44,
                color: Colors.white,
              ), // Bigger icon
            ),
          ],
        );
      case StopwatchState.running:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _logic.stop();
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                minimumSize: const Size(80, 80),
              ),
              child: Icon(Icons.pause, size: 44, color: Colors.white),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                _logic.reset(_updateFormattedTime);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                minimumSize: const Size(80, 80),
              ),
              child: Icon(Icons.replay, size: 44, color: Colors.white),
            ),
          ],
        );
      case StopwatchState.paused:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _logic.resume(_updateFormattedTime);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                minimumSize: const Size(80, 80),
              ),
              child: Icon(Icons.play_arrow, size: 44, color: Colors.white),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                _logic.reset(_updateFormattedTime);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                minimumSize: const Size(80, 80),
              ),
              child: Icon(Icons.replay, size: 44, color: Colors.white),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(preferredSize: Size.fromHeight(60), child: Header(title: 'Stopwatch',)),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _logic.formattedTime,
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w400,
              fontFamily: 'RobotoMono',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 340),
          _buildButtons(context),
        ],
      ),
    bottomNavigationBar: Bottombar(),
    );
  }
}

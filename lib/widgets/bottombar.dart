import 'package:flutter/material.dart';
import 'package:wakeup/screens/alarm/alarmlistscreen.dart';
import 'package:wakeup/screens/stopwatch/StopWatchScreen.dart';
import 'package:wakeup/screens/timer/maintimerpage.dart';
import 'package:wakeup/screens/universaltime/universaltime.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  BottombarState createState() => BottombarState();
}

class BottombarState extends State<Bottombar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        // Optionally set primaryColor, textTheme, etc.
      ),
      child: SizedBox(
        height: 150,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: [
             BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlarmListScreen()),
                  );
                },
                child: Icon(Icons.alarm, size: 34, color: Colors.black),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StopwatchScreen()),
                  );
                },
                child: Icon(Icons.timer, size: 34, color: Colors.black),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainTimerPage()),
                  );
                },
                child: Icon(
                  Icons.hourglass_bottom,
                  size: 34,
                  color: Colors.black,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Universaltime()),
                  );
                },
                child: Icon(Icons.public, size: 34, color: Colors.black),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

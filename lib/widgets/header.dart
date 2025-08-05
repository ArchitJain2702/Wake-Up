import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:wakeup/setting/onemoretryonflutternotification.dart';

class Header extends StatefulWidget {
  final String title; // Make title final for immutability
  const Header({super.key, required this.title}); // Add const constructor

  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      title: Text(
        widget.title, // Use widget.title
        style: const TextStyle(
          color: Colors.black,
          fontSize: 40,
          fontFamily: 'RobotoMono',
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, size: 30),
          onPressed: () async {
            await Alarm.set(alarmSettings: createAlarmSettings(nextfour, 999));
            print(nextfour);
          },
        ),
      ],
    );
  }
}

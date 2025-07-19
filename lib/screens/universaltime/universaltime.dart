import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:wakeup/widgets/bottombar.dart';
import 'dart:async';
import 'package:wakeup/widgets/header.dart';

class Universaltime extends StatefulWidget {
  const Universaltime({super.key});

  @override
  State<Universaltime> createState() => Timepage();
}

class Timepage extends State<Universaltime> {
  late DateTime now;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getTimeInZone(String zoneName) {
    final location = tz.getLocation(zoneName);
    final time = tz.TZDateTime.from(now, location);
    return DateFormat.jm().format(time);
  }

  Widget buildCityTimeRow(String city, String zoneName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            city,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
          ),
          Text(
            getTimeInZone(zoneName),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final indiaTime = getTimeInZone('Asia/Kolkata');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(title: 'Current Time'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 70),
          Center(
            child: Column(
              children: [
                Text(
                  indiaTime,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  "India",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  DateFormat('EEEE, d MMMM yyyy').format(now),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Divider(thickness: 1, indent: 24, endIndent: 24),
          buildCityTimeRow("Dubai", "Asia/Dubai"),
          buildCityTimeRow("London", "Europe/London"),
          buildCityTimeRow("New York", "America/New_York"),
        ],
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}

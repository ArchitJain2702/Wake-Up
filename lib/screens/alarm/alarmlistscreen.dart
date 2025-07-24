import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wakeup/model/alarm.dart';
import 'package:wakeup/screens/alarm/editalar.dart';
import 'package:wakeup/screens/alarm/setalarm.dart';
import 'package:wakeup/setting/onemoretryonflutternotification.dart';
import 'package:wakeup/widgets/bottombar.dart';
import 'package:wakeup/widgets/header.dart';




class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({super.key});

  @override
  State<AlarmListScreen> createState() => _AlarmListScreenState();
}
class _AlarmListScreenState extends State<AlarmListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(title: 'Alarms'),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: globalAlarms.length,
          itemBuilder: (context, index) {
            final alarm = globalAlarms[index];
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditAlarm(alarm: alarm),
                  ),
                );
                setState(() {});
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${alarm.hours.toString().padLeft(2, '0')}:${alarm.minutes.toString().padLeft(2, '0')} ${alarm.ampm}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: alarm.days.map((day) {
                                    return Text(
                                      day,
                                      style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            activeColor: Colors.blue,
                            value: alarm.isActive,
                            onChanged: (value) {
                              setState(() {
                                alarm.isActive = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey, height: 1),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 222, 51, 39),
        foregroundColor: Colors.white,
        onPressed: () async {
          await Alarm.set(alarmSettings: alarmSettings);
              print("Scheduled test notification!defrgjreg9jerg9regjherh9j5h9jt9yh5e9th5ethe5hdfjergrejghjtrhtehdjehjehje5hthdetihtehjth");
              print("nextseven = ${nextseven.year}-${nextseven.month}-${nextseven.day} "
      "${nextseven.hour}:${nextseven.minute}:${nextseven.second}");

          print("specifieddate = ${specifieddate.year}-${specifieddate.month}-${specifieddate.day} "
      "${specifieddate.hour}:${specifieddate.minute}:${specifieddate.second}");

        },

        child: const Icon(Icons.add, size: 30),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}

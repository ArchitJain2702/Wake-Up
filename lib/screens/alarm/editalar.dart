import 'package:flutter/material.dart';
import 'package:wakeup/model/alarm.dart';
import 'package:alarm/alarm.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:wakeup/setting/thinking.dart';
import 'package:wakeup/widgets/challengeslist.dart';
import 'package:wakeup/widgets/discriptionofchallenge.dart';

class EditAlarm extends StatefulWidget {
  final AlarmItems alarm;
  const EditAlarm({super.key, required this.alarm});

  @override
  State<EditAlarm> createState() => EditAlarmState();
}

class EditAlarmState extends State<EditAlarm> {
  late int hours;
  late int minutes;
  late String ampm;
  late List<String> selectedDays;
  bool isChallengeEnabled = false;
  final List<String> daysOfWeek = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  @override
  void initState() {
    super.initState();
    hours = widget.alarm.hours;
    minutes = widget.alarm.minutes;
    ampm = (widget.alarm.ampm == 'am' || widget.alarm.ampm == 'pm')
        ? widget.alarm.ampm
        : 'am';
    selectedDays = List.from(widget.alarm.days);
  }

  void toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  Widget dayButton(String day) {
    final isSelected = selectedDays.contains(day);
    return GestureDetector(
      onTap: () => toggleDay(day),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.black.withOpacity(0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          day,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget numberSelector({
    required int value,
    required void Function(int) onChanged,
    required int count,
  }) {
    return SizedBox(
      height: 120,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        controller: FixedExtentScrollController(initialItem: value),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) => Center(
            child: Text(
              index.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: index == value ? Colors.black : Colors.black26,
              ),
            ),
          ),
          childCount: count,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                  ),
                  Text(
                    'Edit Alarm',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 40),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Time Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: numberSelector(
                      value: hours,
                      onChanged: (value) => setState(() => hours = value),
                      count: 13,
                    ),
                  ),
                  Expanded(
                    child: numberSelector(
                      value: minutes,
                      onChanged: (value) => setState(() => minutes = value),
                      count: 60,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 120,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 50,
                        physics: FixedExtentScrollPhysics(),
                        controller: FixedExtentScrollController(
                          initialItem: ampm == 'am' ? 0 : 1,
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            ampm = index == 0 ? 'am' : 'pm';
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 2,
                          builder: (context, index) {
                            final label = index == 0 ? 'am' : 'pm';
                            return Center(
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: label.toLowerCase() == ampm
                                      ? Colors.black
                                      : Colors.black26,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),
              Text(
                'Repeat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Wrap(children: daysOfWeek.map((d) => dayButton(d)).toList()),

              SizedBox(height: 25),
              Text(
                'Challenges',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Challenges', style: TextStyle(fontSize: 16)),
                  Switch(
                    value: isChallengeEnabled,
                    onChanged: (value) =>
                        setState(() => isChallengeEnabled = value),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  final result =
                      await showModalBottomSheet<Map<String, dynamic>>(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.all(0),
                            child: ChallengeList(context),
                          );
                        },
                      );

                  if (result != null) {
                    setState(() {
                      isChallengeEnabled = true;

                      // Convert string back to enum
                      widget.alarm.challengename = ChallengeTypes.values
                          .firstWhere(
                            (e) =>
                                e.toString().split('.').last.toLowerCase() ==
                                result['challenge'].toString().toLowerCase(),
                            orElse: () => ChallengeTypes.Maths,
                          );

                      widget.alarm.repetitions = result['repetitions'];
                    });
                  }
                },
                // You handle this
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Set Challenge'),
              ),
              ElevatedButton( 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: (){},
                 child: Text(widget.alarm.challengename.toString().split('.').last,
                 style: TextStyle(color: Colors.black),
                 ),
                  ),

              Spacer(),
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (hours != 0) {
                      widget.alarm.seconds = 0;
                      widget.alarm.minutes = minutes;
                      widget.alarm.hours = hours;
                      widget.alarm.days = selectedDays;
                      widget.alarm.ampm = ampm;
                      widget.alarm.isActive = true;
                      widget.alarm.challenges = isChallengeEnabled;
                      if (ampm != 'am' && ampm != 'pm') {
                        ampm = 'am'; // or prompt the user
                      }
                      getUpcomingAlarms(
                        convertTo24Hour(hours, ampm),
                        minutes,
                        convertWeekdayStringsToInts(selectedDays),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please set a valid time for the alarm.',
                          ),
                        ),
                      );
                    } //} You handle saving
                  }, // You handle saving
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade200,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Save', style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

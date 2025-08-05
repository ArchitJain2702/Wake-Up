import 'package:alarm/alarm.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:wakeup/setting/onemoretryonflutternotification.dart';

void getUpcomingAlarms(int hour, int minute, List<int> weekdays) async {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  final List<tz.TZDateTime> alarms = [];

  for (int i = 0; i <= 7; i++) {
    final day = now.add(Duration(days: i));
    final alarmTime = tz.TZDateTime(
      tz.local,
      day.year,
      day.month,
      day.day,
      hour,
      minute,
    );

    // Check if this day matches selected weekdays
    if (weekdays.contains(alarmTime.weekday)) {
      // Only allow today if alarm time is still in future
      if (i == 0 && alarmTime.isBefore(now)) continue;

      alarms.add(alarmTime);
    }
  }
  for (int i = 0; i < alarms.length; i++) {
    final temp = tz.TZDateTime(
      kolkata, // or tz.getLocation('Asia/Kolkata') if needed
      alarms[i].year, // year
      alarms[i].month, // month (July)
      alarms[i].day, // day
      alarms[i].hour, // hour (1 AM)
      alarms[i].minute, // minute
    );

    await Alarm.set(alarmSettings: createAlarmSettings(temp, i + 410));
    print("Device now: ${DateTime.now()}");
    print("my last fucking try: ${temp}");
  }
}

List<int> convertWeekdayStringsToInts(List<String> days) {
  final Map<String, int> dayMap = {
    'sun': 7,
    'mon': 1,
    'tue': 2,
    'wed': 3,
    'thu': 4,
    'fri': 5,
    'sat': 6,
  };

  return days.map((day) {
    final lower = day.toLowerCase();
    if (!dayMap.containsKey(lower)) {
      throw ArgumentError("Invalid weekday string: $day");
    }
    return dayMap[lower]!;
  }).toList();
}

int convertTo24Hour(int hour, String ampm) {
  if (hour < 1 || hour > 12) {
    throw ArgumentError("Hour must be between 1 and 12");
  }

  final normalized = ampm.trim().toUpperCase();

  if (normalized == 'AM') {
    return hour == 12 ? 0 : hour;
  } else if (normalized == 'PM') {
    return hour == 12 ? 12 : hour + 12;
  } else {
    throw ArgumentError("am/pm must be either 'am' or 'pm'");
  }
}

import 'package:timezone/timezone.dart' as tz;

enum ChallengeTypes { Maths, Memory, Focus, Reaction }

class AlarmItems {
  int seconds;
  int minutes;
  int hours;
  String ampm;
  List<String> days;
  bool isActive;
  bool challenges;
  ChallengeTypes challengename;
  int repetitions;

  AlarmItems({
    required this.seconds,
    required this.minutes,
    required this.hours,
    required this.days,
    required this.ampm,
    this.isActive = true,
    required this.challenges,
    this.challengename = ChallengeTypes.Maths,
    this.repetitions = 3,
  });
}

void addGlobalAlarm(AlarmItems alarm) {
  globalAlarms.add(alarm);
}

List<AlarmItems> globalAlarms = [
  AlarmItems(
    seconds: 0,
    minutes: 0,
    hours: 0,
    days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    ampm: 'am',
    isActive: true,
    challenges: true,
    challengename:ChallengeTypes.Memory
  ),
  AlarmItems(
    seconds: 30,
    minutes: 0,
    hours: 6,
    days: ['Sat', 'Sun'],
    ampm: 'pm',
    isActive: true,
    challenges: false,
  ),
];

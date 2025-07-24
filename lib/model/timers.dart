class TimerItems {
   String title;
   int seconds;
   int minutes;
   int hours;
  TimerItems({
    required this.title,
    required this.seconds,
    required this.minutes,
    required this.hours,
  });
}
void addGlobalTimer(TimerItems timer) {
  globalTimers.add(timer);
}

// Global list of timers accessible from anywhere
List<TimerItems> globalTimers = [
 TimerItems(title: 'fuckyou', seconds: 2, minutes:0, hours: 0),
  TimerItems(title: 'fuckyou2', seconds: 4, minutes:8, hours: 0),
  TimerItems(title: 'fuckyou3', seconds: 4, minutes:8, hours: 0),
];

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart' as tz;
final kolkata = tz.getLocation('Asia/Kolkata');


final tz.TZDateTime nextseven = tz.TZDateTime.from(
  DateTime.now().add(Duration(seconds: 3)),
  kolkata
);
final specifieddate = tz.TZDateTime(
  kolkata,      // or tz.getLocation('Asia/Kolkata') if needed
  2025,          // year
  7,             // month (July)
  24,            // day
  18,             // hour (1 AM)
  48,            // minute
);

final alarmSettings = AlarmSettings(
  id: 42,
  dateTime: specifieddate,
  assetAudioPath: 'assets/audio/alarm2.mp3',
  loopAudio: true,
  vibrate: true,

  androidFullScreenIntent: true,
  volumeSettings: VolumeSettings.fade(
    volume: 0.8,
    fadeDuration: Duration(seconds: 5),
    volumeEnforced: true,
  ),
  notificationSettings: const NotificationSettings(
    title: 'This is the title',
    body: 'This is the body',
    stopButton: 'Stop the alarm',
    icon: 'notification_icon',
    iconColor: Color(0xff862778),
  ),
);
AlarmSettings createAlarmSettings(DateTime dateTime, int id) {
  return AlarmSettings(
    id: id,
    dateTime: dateTime,
    assetAudioPath: 'assets/audio/alarm2.mp3',
    loopAudio: true,
    vibrate: true,
    androidFullScreenIntent: true,
    volumeSettings: VolumeSettings.fade(
      volume: 0.8,
      fadeDuration: Duration(seconds: 5),
      volumeEnforced: true,
    ),
    notificationSettings: const NotificationSettings(
      title: 'This is the title',
      body: 'This is the body',
      stopButton: 'Stop the alarm',
      icon: 'notification_icon',
      iconColor: Color(0xff862778),
    ),
  );
}




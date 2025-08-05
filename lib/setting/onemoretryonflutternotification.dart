import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart' as tz;

final kolkata = tz.getLocation('Asia/Kolkata');

final tz.TZDateTime nextfour = tz.TZDateTime.from(
  DateTime.now().add(Duration(seconds: 8)),
  kolkata,
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
    notificationSettings: NotificationSettings(
      title: 'This is the title',
      body: 'This is the body',
      icon: 'notification_icon',
      iconColor: Color(0xff862778),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:wakeup/screens/timer/maintimerpage.dart';
class Alarmscreen extends StatefulWidget {
  const  Alarmscreen({super.key});
  @override
  State<Alarmscreen> createState() => AlarmScreenState();
}

class AlarmScreenState extends State<Alarmscreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    playAlarm();
  }

  Future<void> playAlarm() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('audio/alarm1.mp3'));
  }

  Future<void> stopAlarm() async {
    await _audioPlayer.stop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MainTimerPage()),
    ); 
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 160,),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Time's Up!",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 300),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(
                         onPressed: stopAlarm,
                         style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        backgroundColor: Colors.red,
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text("Dismiss",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}

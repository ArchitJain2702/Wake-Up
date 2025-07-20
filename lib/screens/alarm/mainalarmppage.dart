import 'package:flutter/material.dart';
class MainAlarmPage extends StatefulWidget {
  const MainAlarmPage({ super.key});
  @override
  MainalarmppageState createState() => MainalarmppageState();
}
class MainalarmppageState extends State<MainAlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Page'),
      ),
      body: Center(
        child: Text('This is the main alarm page.'),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:wakeup/model/timers.dart';
import 'package:wakeup/widgets/bottombar.dart';
import 'package:wakeup/widgets/header.dart';

class Settimer extends StatefulWidget {
  const Settimer({super.key});

  @override
  State<Settimer> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<Settimer> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  Widget _buildTimeInput(String label, TextEditingController controller) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number, // Shows number pad directly
            decoration: InputDecoration(
              hintText: "00",
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Text(text,style: TextStyle(fontSize: 16),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Closes keyboard when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:PreferredSize(preferredSize: Size.fromHeight(60), child: Header(title: 'Set Timer',)),
        body: Padding(
          padding: const EdgeInsets.all(34),
          child: Column(
            children: [
              Row(
                children: [
                  _buildTimeInput("Hours", _hoursController),
                  const SizedBox(width: 16),
                  _buildTimeInput("Minutes", _minutesController),
                ],
              ),
              const SizedBox(height: 34),
              _buildTimeInput("Seconds", _secondsController),
              const SizedBox(height: 32),
              Row(
                children: [
                  _buildButton("Cancel", Colors.blue.shade100, () {
                    Navigator.pop(context);
                  }),
                  _buildButton("Reset", Colors.blue.shade100, () {
                    _hoursController.clear();
                    _minutesController.clear();
                    _secondsController.clear();
                  }),
                ],
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 190,
                child: _buildButton("Save", Colors.blue.shade300, () {
                  String hours = _hoursController.text;
                  String minutes = _minutesController.text;
                  String seconds = _secondsController.text;
                  if (hours.isEmpty) hours = "0";
                  if (minutes.isEmpty) minutes = "0";
                  if (seconds.isEmpty) seconds = "0";
                  if((hours == "0" && minutes == "0" && seconds == "0")|| int.parse(seconds) > 59 || int.parse(minutes) > 59 || int.parse(hours) > 23) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please set a valid timer!"))
                    );
                    return;
                  }else {
                    addGlobalTimer(TimerItems(
                      title: "Timer",
                      seconds: int.parse(seconds),
                      minutes: int.parse(minutes),
                      hours: int.parse(hours),
                    ));
                    Navigator.pop(context);
                  }
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Bottombar(),
      ),
    );
  }
}

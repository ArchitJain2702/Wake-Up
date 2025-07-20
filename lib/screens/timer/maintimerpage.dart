import 'package:flutter/material.dart';
import 'package:wakeup/model/timers.dart';
import 'package:wakeup/screens/timer/runningtimer.dart';
import 'package:wakeup/screens/timer/settimer.dart';
import 'package:wakeup/widgets/bottombar.dart';
import 'package:wakeup/widgets/header.dart';

class MainTimerPage extends StatefulWidget {
  const MainTimerPage({super.key});
  @override
  State<MainTimerPage> createState() => MaintimerpageState();
}

class MaintimerpageState extends State<MainTimerPage> {
  final List<TimerItems> timers = globalTimers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(title: 'Saved Timers'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: ListView.builder(
          itemCount: timers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                timers[index].title,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              subtitle: Text(
                "${timers[index].hours}h ${timers[index].minutes}m ${timers[index].seconds}s",
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min, // Prevents taking up full width
                children: [
                  GestureDetector(
                    onTap: () async {
                      // Show dialog and wait for result
                      final newName = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          final TextEditingController controller =
                              TextEditingController();
                          return AlertDialog(
                            backgroundColor: Colors.white,

                            title: const Text("Rename"),
                            content: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: "Enter the new  name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                  ); // close without returning anything
                                },
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue.shade300,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  final name = controller.text.trim();
                                  if (name.isNotEmpty) {
                                    Navigator.pop(context, name); // return name
                                  }
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          );
                        },
                      );

                      // If a name was returned and not null/empty, update the title
                      if (newName != null && newName.isNotEmpty) {
                        setState(() {
                          timers[index] = TimerItems(
                            title: newName,
                            hours: timers[index].hours,
                            minutes: timers[index].minutes,
                            seconds: timers[index].seconds,
                          );
                        });
                      }
                    },
                    child: Icon(
                      Icons.drive_file_rename_outline,
                      size: 22,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CustomTimerScreen(
                            timerName: timers[index].title,
                            hours: timers[index].hours,
                            minutes: timers[index].minutes,
                            seconds: timers[index].seconds,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.play_arrow,
                      size: 42,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Trigger timer logic here
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: Color.fromARGB(255, 235, 46, 52),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Timer', style: TextStyle(color: Colors.white)),
        onPressed: () async {
          // Navigate to new timer screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Settimer()),
          ).then((value) {
            // Refresh the timers list after returning from Settimer
            setState(() {});
          });
        },
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}

import 'dart:math';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class SentenceTypingChallengeScreen extends StatefulWidget {
  final int totalQuestions;

  const SentenceTypingChallengeScreen({
    super.key,
    required this.totalQuestions,
  });

  @override
  State<SentenceTypingChallengeScreen> createState() => _SentenceTypingChallengeScreenState();
}

class _SentenceTypingChallengeScreenState extends State<SentenceTypingChallengeScreen> {
  final TextEditingController _sentenceController = TextEditingController();
  late String targetSentence;
  int currentQuestion = 1;

  @override
  void initState() {
    super.initState();
    targetSentence = generateRandomSentence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Progress text
              Center(
                child: Text(
                  '$currentQuestion/${widget.totalQuestions} completed',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 34),

              // Title
              const Center(
                child: Text(
                  "Type it upp...",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle

              const SizedBox(height: 40),

              // Sentence to type
              Center(
                child: Text(
                  targetSentence,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 90),

              // Input field
              TextField(
                controller: _sentenceController,
                minLines: 1,
                maxLines: 5,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  hintText: "Type the sentence here",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                ),
              ),

              const SizedBox(height: 110),

              // Submit button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _handleSubmit,
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_sentenceController.text.trim() == targetSentence.trim()) {
      setState(() {
        currentQuestion++;
        if (currentQuestion <= widget.totalQuestions) {
          targetSentence = generateRandomSentence();
          _sentenceController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Well done! Alarm dismissed.")),
          );
          Alarm.stopAll();
          Navigator.pop(context);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect. Please type exactly as shown.")),
      );
    }
  }

  String generateRandomSentence() {
    final random = Random();

    final subjects = ['The cat', 'A boy', 'My dog', 'An artist', 'The robot'];
    final verbs = ['jumps', 'runs', 'sleeps', 'writes', 'eats'];
    final adjectives = ['quickly', 'quietly', 'gracefully', 'happily', 'suddenly'];
    final objects = ['on the bed', 'over the wall', 'in the room', 'under the tree', 'on a chair'];
    final endings = ['every day.', 'without stopping.', 'before lunch.', 'in summer.', 'for fun.'];

    return "${subjects[random.nextInt(subjects.length)]} "
           "${verbs[random.nextInt(verbs.length)]} "
           "${adjectives[random.nextInt(adjectives.length)]} "
           "${objects[random.nextInt(objects.length)]} "
           "${endings[random.nextInt(endings.length)]}";
  }
}

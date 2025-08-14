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
  State<SentenceTypingChallengeScreen> createState() =>
      _SentenceTypingChallengeScreenState();
}

class _SentenceTypingChallengeScreenState
    extends State<SentenceTypingChallengeScreen> {
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
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress text
              Center(
                child: Text(
                  '$currentQuestion/${widget.totalQuestions} completed',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 70),

              // Title
              const Center(
                child: Text(
                  "Type it up...",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sentence card
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    targetSentence,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // Input field
              TextField(
                controller: _sentenceController,
                minLines: 1,
                maxLines: 5,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  hintText: "Type the sentence here...",
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 1.2),
                  ),
                ),
              ),

              const Spacer(),

              // Submit button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 38, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                    shadowColor: Colors.deepPurple.withOpacity(0.3),
                  ),
                  onPressed: _handleSubmit,
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 70),
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

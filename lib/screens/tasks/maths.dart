import 'dart:math';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:wakeup/widgets/mathchallenge.dart';

class MathChallengeScreen extends StatefulWidget {
  final int totalQuestions;
  const MathChallengeScreen({
    super.key,
    required this.totalQuestions,
  });

  @override
  State<MathChallengeScreen> createState() => MathChallengeScreenState();
}

class MathChallengeScreenState extends State<MathChallengeScreen> {
  final TextEditingController _answerController = TextEditingController();
  var challenge = generateMathChallenge();
  late int currentQuestion = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Repetition count like "3/6 completed"
              Center(
                child: Text(
                  '${currentQuestion}/${widget.totalQuestions} completed',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 34),

              // Heading
              const Center(
                child: Text(
                  "Solve these problems to\ndismiss the alarm",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 70),

              // Math question
              Center(
                child: Text(
                  challenge['question'],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Dynamic answer input box
              TextField(
                controller: _answerController,
                keyboardType: TextInputType.number,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter your answer",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                ),
              ),

              const SizedBox(height: 162),

              // Submit button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade400,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    int userAnswer = int.tryParse(_answerController.text) ?? 0;
                    if (userAnswer == challenge['answer']) {
                      // If the answer is correct, generate a new challenge
                      setState(() {
                        currentQuestion++;
                        if (currentQuestion <= widget.totalQuestions) {
                          challenge = generateMathChallenge();
                          _answerController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Good job! Alarm dismissed!"),
                            ),
                          );
                          Alarm.stopAll();
                          Navigator.of(
                            context,
                          ).pop(); // Go back to the previous screen
                        }
                      });
                      // Show an error message or handle incorrect answer
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Incorrect answer, try again!"),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Submit Answer",
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
}

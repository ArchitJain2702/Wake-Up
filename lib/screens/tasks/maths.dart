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
  State<MathChallengeScreen> createState() => _MathChallengeScreenState();
}

class _MathChallengeScreenState extends State<MathChallengeScreen> {
  final TextEditingController _answerController = TextEditingController();
  var challenge = generateMathChallenge();
  late int currentQuestion = 1;

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
                  "Solve these problems to\ndismiss the alarm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Math question card
              Center(
                child: Container(
                  width: double.infinity,
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
                    challenge['question'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Answer input field
              TextField(
                controller: _answerController,
                keyboardType: TextInputType.number,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter your answer",
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
                    "Submit Answer",
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
    int userAnswer = int.tryParse(_answerController.text) ?? 0;
    if (userAnswer == challenge['answer']) {
      setState(() {
        currentQuestion++;
        if (currentQuestion <= widget.totalQuestions) {
          challenge = generateMathChallenge();
          _answerController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Good job! Alarm dismissed!")),
          );
          Alarm.stopAll();
          Navigator.pop(context);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect answer, try again!")),
      );
    }
  }
}

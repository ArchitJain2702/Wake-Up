import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class MemoryChallengeScreen extends StatefulWidget {
  final int totalQuestions;

  const MemoryChallengeScreen({
    super.key,
    required this.totalQuestions,
  });

  @override
  State<MemoryChallengeScreen> createState() => MemoryChallengeScreenState();
}

class  MemoryChallengeScreenState extends State<MemoryChallengeScreen> {
  final Color baseColor = Colors.grey.shade800; // Neutral base for grid
  final int gridSize = 9; // 3x3
  late List<int> sequence;
  List<int> userSequence = [];
  int currentQuestion = 1;
  bool sequenceShown = false;

  @override
  void initState() {
    super.initState();
    _generateSequence();
  }

  void _generateSequence() {
    List<int> positions = List.generate(gridSize, (index) => index);
    positions.shuffle();
    sequence = positions.take(4).toList(); // Sequence length
    userSequence.clear();
    sequenceShown = false;
    _showSequence();
  }

  Future<void> _showSequence() async {
    setState(() => sequenceShown = false);
    for (int pos in sequence) {
      setState(() => userSequence = [pos]);
      await Future.delayed(const Duration(milliseconds: 600));
      setState(() => userSequence = []);
      await Future.delayed(const Duration(milliseconds: 300));
    }
    setState(() {
      sequenceShown = true;
      userSequence = [];
    });
  }

  void _handleBoxTap(int index) {
    if (!sequenceShown) return;
    setState(() {
      userSequence.add(index);
    });
  }

  void _handleSubmit() async {
    if (userSequence.length != sequence.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect! New pattern coming...")),
      );
      setState(() => userSequence.clear());
      await Future.delayed(const Duration(seconds: 1));
      _generateSequence();
      return;
    }

    bool isCorrect = true;
    for (int i = 0; i < sequence.length; i++) {
      if (sequence[i] != userSequence[i]) {
        isCorrect = false;
        break;
      }
    }

    if (isCorrect) {
      setState(() {
        currentQuestion++;
        if (currentQuestion <= widget.totalQuestions) {
          _generateSequence();
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
        const SnackBar(content: Text("Incorrect! New pattern coming...")),
      );
      setState(() => userSequence.clear());
      await Future.delayed(const Duration(seconds: 1));
      _generateSequence();
    }
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
              // Progress
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
              const SizedBox(height: 50),

              // Title
              const Center(
                child: Text(
                  "Repeat the shown pattern\nto dismiss the alarm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Grid (keeps old dark design)
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: gridSize,
                  itemBuilder: (context, index) {
                    bool isSequenceHighlight =
                        !sequenceShown && userSequence.contains(index);
                    bool isSelected =
                        sequenceShown && userSequence.contains(index);

                    return InkWell(
                      onTap: () => _handleBoxTap(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isSequenceHighlight || isSelected
                              ? Colors.grey.shade600
                              : baseColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Submit button with purple style
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
                    "Submit Pattern",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

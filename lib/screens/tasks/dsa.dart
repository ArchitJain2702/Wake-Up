import 'dart:math';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class DsaMcqChallengeScreen extends StatefulWidget {
  final int totalQuestions;

  const DsaMcqChallengeScreen({
    super.key,
    required this.totalQuestions,
  });

  @override
  State<DsaMcqChallengeScreen> createState() => _DsaMcqChallengeScreenState();
}

class _DsaMcqChallengeScreenState extends State<DsaMcqChallengeScreen> {
  late Map<String, dynamic> currentMcq;
  int currentQuestion = 1;
  String? selectedOption;
final List<Map<String, dynamic>> mcqList = [
  {"question": "Which data structure uses LIFO?", "options": ["Queue", "Stack", "Tree", "Graph"], "answer": "Stack"},
  {"question": "Which sorting has O(n^2) in worst case?", "options": ["Merge Sort", "Quick Sort", "Bubble Sort", "Heap Sort"], "answer": "Bubble Sort"},
  {"question": "Which traversal visits root first?", "options": ["Inorder", "Preorder", "Postorder", "Level Order"], "answer": "Preorder"},
  {"question": "Which is not linear data structure?", "options": ["Stack", "Queue", "Array", "Graph"], "answer": "Graph"},
  {"question": "Binary search requires?", "options": ["Sorted array", "Unsorted array", "Graph", "Tree only"], "answer": "Sorted array"},
  {"question": "DFS uses which data structure?", "options": ["Queue", "Stack", "Array", "Heap"], "answer": "Stack"},
  {"question": "Which is used for BFS?", "options": ["Stack", "Queue", "Tree", "Array"], "answer": "Queue"},
  {"question": "Time complexity of merge sort?", "options": ["O(n^2)", "O(n log n)", "O(log n)", "O(n)"], "answer": "O(n log n)"},
  {"question": "Which is an example of divide and conquer?", "options": ["Merge Sort", "Bubble Sort", "Insertion Sort", "Selection Sort"], "answer": "Merge Sort"},
  {"question": "Which is fastest for small data?", "options": ["Merge Sort", "Quick Sort", "Insertion Sort", "Heap Sort"], "answer": "Insertion Sort"},
  {"question": "Which data structure is FIFO?", "options": ["Queue", "Stack", "Deque", "Graph"], "answer": "Queue"},
  {"question": "Which tree has at most two children per node?", "options": ["Binary Tree", "Ternary Tree", "AVL Tree", "B-Tree"], "answer": "Binary Tree"},
  {"question": "Which sorting algorithm is stable?", "options": ["Merge Sort", "Quick Sort", "Heap Sort", "Selection Sort"], "answer": "Merge Sort"},
  {"question": "Which operation is O(1) in a stack?", "options": ["Push", "Search", "Sort", "Traverse"], "answer": "Push"},
  {"question": "In a max heap, parent node is?", "options": ["Smaller than children", "Larger than children", "Equal to children", "Random"], "answer": "Larger than children"},
  {"question": "Which traversal uses a queue?", "options": ["BFS", "DFS", "Inorder", "Preorder"], "answer": "BFS"},
  {"question": "What does 'O(1)' time mean?", "options": ["Constant time", "Linear time", "Logarithmic time", "Quadratic time"], "answer": "Constant time"},
  {"question": "Which search is better for sorted arrays?", "options": ["Binary Search", "Linear Search", "DFS", "BFS"], "answer": "Binary Search"},
  {"question": "Which algorithm is greedy?", "options": ["Kruskal's", "Merge Sort", "DFS", "Binary Search"], "answer": "Kruskal's"},
  {"question": "In adjacency list representation, space complexity is?", "options": ["O(V+E)", "O(V^2)", "O(E^2)", "O(VE)"], "answer": "O(V+E)"},
];

  @override
  void initState() {
    super.initState();
    currentMcq = _generateRandomMcq();
  }

  Map<String, dynamic> _generateRandomMcq() {
    final random = Random();
    return mcqList[random.nextInt(mcqList.length)];
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                ),
              ),

              const SizedBox(height: 70),

              // Title
              const Center(
                child: Text(
                  "Answer these to\ndismiss the alarm",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),

              const SizedBox(height: 80),

              // Question Card
              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
                  ),
                  child: Text(
                    currentMcq['question'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Options grid (2 per row)
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: currentMcq['options'].map<Widget>((option) {
                  final bool isSelected = selectedOption == option;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = option;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.deepPurple : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 4,
                    shadowColor: Colors.deepPurple.withOpacity(0.3),
                  ),
                  onPressed: _handleSubmit,
                  child: const Text("Submit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
    if (selectedOption == currentMcq['answer']) {
      setState(() {
        currentQuestion++;
        if (currentQuestion <= widget.totalQuestions) {
          currentMcq = _generateRandomMcq();
          selectedOption = null;
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



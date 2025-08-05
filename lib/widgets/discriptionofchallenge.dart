import 'package:flutter/material.dart';

class DescriptionWidget extends StatefulWidget {
  final String topic;
  const DescriptionWidget({super.key, required this.topic});

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  int selectedCount = 6;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1200,
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(vertical: 38, horizontal: 32),
      child: Column(
        children: [
          Text(
            widget.topic,
            style: TextStyle(color: Colors.white70, fontSize: 25),
          ),
          SizedBox(
            height: 120,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 50,
              diameterRatio: 1.2,
              physics: FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedCount = index + 3;
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 18,
                builder: (context, index) {
                  int num = index + 3;
                  bool isSelected = num == selectedCount;
                  return Center(
                    child: Text(
                      '$num',
                      style: TextStyle(
                        fontSize: isSelected ? 36 : 28,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 40),
          Text(
            'No. of repetitions',
            style: TextStyle(color: Colors.white70, fontSize: 26),
          ),
          SizedBox(height: 70),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                'challenge': widget.topic,
                'repetitions': selectedCount,
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 80, 80, 80),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ), // changed to RoundedRectangleBorder for compatibility
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text("Confirm", style: TextStyle(fontSize: 25)),
          ),
        ],
      ),
    );
  }
}

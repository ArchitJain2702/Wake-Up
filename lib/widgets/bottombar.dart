import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
  const Bottombar ({super.key});

  @override
  _BottombarState createState() => _BottombarState();
}
class _BottombarState extends State<Bottombar>{
  @override
  Widget build(BuildContext context){
    return Theme(
  data: Theme.of(context).copyWith(
    canvasColor: Colors.white,
    // Optionally set primaryColor, textTheme, etc.
  ),
  child: SizedBox(
    height: 150,
    child: BottomNavigationBar(
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.timer,size: 34, color: Colors.black), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.alarm, size:34,color:  Colors.black), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.hourglass_bottom,size: 34, color: Colors.black), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.public,size: 34, color: Colors.black), label: ''),
      ],
    ),
  ),
);
  }
}
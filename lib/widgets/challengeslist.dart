import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wakeup/widgets/discriptionofchallenge.dart';

Widget ChallengeList(BuildContext context) =>Container(
  height: 1200,
  decoration: BoxDecoration(
    color: Colors.white,
  ), // or use MediaQuery.of(context).size.height * 0.5
  padding: EdgeInsets.all(16),
  child: Column(
    children: [
      Text('Select Challenge',),
      xyz('Maths',context),
      xyz('Memory',context),
      xyz('Typing',context),
      xyz('DSA',context),
    ],
  ),
);
Column xyz(String title,BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () async {
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => DescriptionWidget(topic: title),
          );

          if (result != null) {
            // This data can be passed back to EditAlarm
            Navigator.pop(context, result); // Pop challenge list with result
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: ListTile(title: Text(title)),
        ),
      ),
      SizedBox(height: 3),
    ],
  );
}

import 'dart:math';

Map<String, dynamic> generateMathChallenge() {
  final random = Random();
  int a = 3 + random.nextInt(7); // 3 to 9
  int b = 3 + random.nextInt(7); // 3 to 9
  int c = 14 + random.nextInt(37); // 14 to 50

  int answer = a * b + c;
  String question = "$a × $b + $c = ?";

  return {
    'question': question,
    'answer': answer,
  };
}

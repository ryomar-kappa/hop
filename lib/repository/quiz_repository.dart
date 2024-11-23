import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hop_client/model/quiz.dart';

class QuizRepository {
  static const String _jsonFilePath = 'assets/quiz_data.json';

  Future<List<Quiz>> fetch() async {
    final String jsonString = await rootBundle.loadString(_jsonFilePath);

    final List<dynamic> jsonData = json.decode(jsonString);

    List<Quiz> quizzes = [];
    for (var item in jsonData) {
      quizzes.add(Quiz(
        question: item['question'],
        choises: List<String>.from(item['choices']),
        correctAnswer: item['correctAnswer'],
        explanation: item['explanation'],
      ));
    }

    return quizzes;
  }
}

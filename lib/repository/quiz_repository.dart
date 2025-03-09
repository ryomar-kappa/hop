import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hop_client/main.dart';
import 'package:hop_client/model/quiz.dart';

class QuizRepository {
  static const String _jsonFilePath = 'assets/quiz_data.json';

  Future<List<Quiz>> _fetchAll() async {
    final String jsonString = await rootBundle.loadString(_jsonFilePath);

    final List<dynamic> jsonData = json.decode(jsonString);

    return jsonData.map((item) {
      return Quiz(
          question: item['question'],
          choices: List<Choice>.from(
            List<Map<String, dynamic>>.from(item['choices'])
                .map((choice) => Choice(
                      value: choice['value'],
                      answer: choice['answer'],
                    )),
          ),
          explanation: item['explanation'],
          level: item['level']);
    }).toList();
  }

  Future<List<Quiz>> fetchByDifficurityLevel(
      DifficultyLevel difficurltyLevel) async {
    final allQuiz = await _fetchAll();
    return allQuiz.where((e) => e.level == difficurltyLevel.level).toList();
  }
}

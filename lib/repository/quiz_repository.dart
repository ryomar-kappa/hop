import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hop_client/model/quiz.dart';

class QuizRepository {
  // JSONファイルのパス
  static const String _jsonFilePath = 'assets/quiz_data.json';

  // JSONデータを非同期に読み込む
  Future<List<Quiz>> fetch() async {
    // アセットからJSONファイルを読み込む
    final String jsonString = await rootBundle.loadString(_jsonFilePath);

    // JSONをデコードしてリストに変換
    final List<dynamic> jsonData = json.decode(jsonString);

    // JSONからQuizオブジェクトを作成
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

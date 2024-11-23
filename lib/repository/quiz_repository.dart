import 'package:hop_client/model/quiz.dart';

class QuizRepository {
  Future<Quiz> fetch() async {
    await Future.delayed(Duration(seconds: 1));
    return Quiz(
        question: '1.ビールの原材料のうち「ビールの魂」と呼ばれるものはどれ？ ',
        choises: ['ホップ', 'モルト', '酵母', '水'],
        correctAnswer: 0,
        explanation: '解説');
  }
}

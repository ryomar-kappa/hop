import 'package:flutter/material.dart';
import 'package:hop_client/app_color.dart';
import 'package:hop_client/model/quiz.dart';
import 'package:hop_client/repository/quiz_repository.dart';
import 'package:hop_client/screen/complete_page/complete_page.dart';

const questionCount = 2;

enum ChoisePrefix {
  a('A'),
  b('B'),
  c('C'),
  d('D');

  final String text;

  const ChoisePrefix(this.text);

  factory ChoisePrefix.fromIndex(int index) {
    switch (index) {
      case 0:
        return ChoisePrefix.a;
      case 1:
        return ChoisePrefix.b;
      case 2:
        return ChoisePrefix.c;
      case 3:
        return ChoisePrefix.d;
      case _:
        throw UnsupportedError('想定していない選択肢');
    }
  }
}

class QuizLoadingView extends StatefulWidget {
  const QuizLoadingView({super.key});

  @override
  State<StatefulWidget> createState() => QuizLoadingState();
}

class QuizLoadingState extends State<QuizLoadingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.headerColor,
        title: const Text(
          '問題',
          style:
              TextStyle(color: AppColor.textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Quiz>>(
          future: QuizRepository().fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              final quiz = snapshot.data!;
              return QuizPageView(quizList: quiz);
            } else {
              return Center(child: Text('データがありません'));
            }
          },
        ),
      ),
    );
  }
}

class QuizPageView extends StatefulWidget {
  const QuizPageView({super.key, required this.quizList});
  final List<Quiz> quizList;

  @override
  State<StatefulWidget> createState() => QuizPage();
}

class QuizPage extends State<QuizPageView> {
  List<bool> choisesState = List.generate(4, (_) => false);
  bool get isCorrect => choisesState.where((e) => e).isNotEmpty;
  int correctCount = 0;
  void onAnswer(int answer) {
    setState(() {
      if (answer != widget.quizList[correctCount].correctAnswer) {
        choisesState[answer] = false;
        choisesState = List.of(choisesState);
      }
      if (answer == widget.quizList[correctCount].correctAnswer) {
        choisesState[answer] = true;
        choisesState = List.of(choisesState);
        correctCount++;
        if (correctCount == questionCount) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CompletePage()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuiz = widget.quizList[correctCount];
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: AppColor.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: QuizArea(
                  question: currentQuiz.question,
                ),
              ),
              Visibility(
                  visible: isCorrect,
                  child: Column(
                    children: [
                      const Text('正解！'),
                      Text(currentQuiz.explanation,
                          style: const TextStyle(
                            color: AppColor.textColor,
                          )),
                      FilledButton(
                          onPressed: () {},
                          child: const Text(
                            '次の問題',
                            style: TextStyle(color: AppColor.textColor),
                          ))
                    ],
                  )),
              ChoisesArea(
                quiz: currentQuiz,
                choisesState: choisesState,
                onAnswer: onAnswer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoisesArea extends StatelessWidget {
  final Quiz quiz;
  final List<bool> choisesState;
  final Function onAnswer;
  const ChoisesArea(
      {super.key,
      required this.choisesState,
      required this.onAnswer,
      required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            quiz.choises.length,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Choises(
                      prefix: ChoisePrefix.fromIndex(index).text,
                      choise: quiz.choises[index],
                      state: choisesState[index],
                      onAnswer: onAnswer,
                      number: index),
                )));
  }
}

class QuizArea extends StatelessWidget {
  const QuizArea({super.key, required this.question});
  final String question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(question,
            style: const TextStyle(
                color: AppColor.textColor, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class Choises extends StatelessWidget {
  final int number;
  final String prefix;
  final String choise;
  final bool state;
  final Function onAnswer;

  const Choises(
      {super.key,
      required this.prefix,
      required this.choise,
      required this.state,
      required this.onAnswer,
      required this.number});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onAnswer(number);
      },
      child: Container(
        height: 64,
        decoration: BoxDecoration(
            color:
                state ? AppColor.correctAnswerColor : AppColor.quizBackground,
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white),
                child: Center(child: Text(prefix)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                choise,
                style: const TextStyle(
                    color: AppColor.quizText, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

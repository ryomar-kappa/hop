import 'package:flutter/material.dart';
import 'package:hop_client/app_color.dart';
import 'package:hop_client/model/choice_prefix.dart';
import 'package:hop_client/model/difficulty_level.dart';
import 'package:hop_client/model/quiz.dart';
import 'package:hop_client/repository/quiz_repository.dart';
import 'package:hop_client/screen/complete_page/complete_page.dart';

class QuizLoadingView extends StatefulWidget {
  final QuizMode mode;
  final DifficultyLevel difficultyLevel;
  const QuizLoadingView(
      {super.key, required this.mode, required this.difficultyLevel});

  @override
  State<StatefulWidget> createState() => QuizLoadingState();
}

class QuizLoadingState extends State<QuizLoadingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.header,
        title: const Text(
          '問題',
          style:
              TextStyle(color: AppColor.textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Quiz>>(
          future:
              QuizRepository().fetchByDifficurityLevel(widget.difficultyLevel),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                {
                  final quizList = snapshot.data!;
                  quizList.shuffle();

                  final questionNum = widget.mode.num;

                  if (quizList.length > questionNum) {
                    quizList.removeRange(questionNum, quizList.length);
                  }
                  for (var quiz in quizList) {
                    quiz.choices.shuffle();
                  }
                  return QuizPageView(quizList: quizList);
                }
              case ConnectionState.none:
              case ConnectionState.active:
                return const Center(child: Text('データがありません'));
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
  int currentQuizCount = 1;
  Choice? selectedChoice;

  void onAnswer() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: AppColor.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              isCorrect() ? '正解' : '不正解',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isCorrect()
                      ? AppColor.correctAnswer
                      : AppColor.incorrectAnswer),
            ),
            content: Text(
              widget.quizList[currentQuizCount - 1].explanation,
              style: const TextStyle(color: AppColor.textColor),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (currentQuizCount == widget.quizList.length) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CompletePage()));
                  } else {
                    Navigator.of(context).pop();
                    setState(() {
                      selectedChoice = null;
                      currentQuizCount++;
                    });
                  }
                },
                child: Text(
                  currentQuizCount == widget.quizList.length
                      ? 'サマリーへ'
                      : '次の問題へ',
                  style: const TextStyle(color: AppColor.textColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool isCorrect() {
    return selectedChoice!.answer;
  }

  void selectChoice(Choice choice) {
    setState(() {
      if (selectedChoice == choice) {
        selectedChoice = null;
      } else {
        selectedChoice = choice;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuiz = widget.quizList[currentQuizCount - 1];
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: AppColor.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: QuestionArea(
                      question: '$currentQuizCount. ${currentQuiz.question}'),
                ),
              ),
              Column(
                children: currentQuiz.choices.map((choice) {
                  int choiceIndex = currentQuiz.choices.indexOf(choice);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ChoiceArea(
                      prefix: ChoicePrefix.fromIndex(choiceIndex).text,
                      choice: choice,
                      isSelected: choice == selectedChoice,
                      onTap: () => selectChoice(choice),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // FIXME: ボタン系は役割に応じて共通化.
                    FilledButton(
                      onPressed:
                          selectedChoice == null ? null : () => onAnswer(),
                      style: FilledButton.styleFrom(
                        backgroundColor: selectedChoice == null
                            ? AppColor.disabledButton
                            : AppColor.generalActionButton,
                      ),
                      child: const Text(
                        '回答',
                        style: TextStyle(color: AppColor.whiteText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionArea extends StatelessWidget {
  const QuestionArea({super.key, required this.question});
  final String question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          question,
          style: const TextStyle(
            color: AppColor.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ChoiceArea extends StatelessWidget {
  final String prefix;
  final Choice choice;
  final bool isSelected;
  final Function onTap;

  const ChoiceArea({
    super.key,
    required this.prefix,
    required this.choice,
    required this.isSelected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      // FIXME: component 化検討.
      child: Container(
        constraints: const BoxConstraints(minHeight: 64),
        decoration: BoxDecoration(
            color: isSelected
                ? AppColor.quizFocusedBackground
                : AppColor.quizBackground,
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Center(child: Text(prefix)),
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                choice.value,
                style: const TextStyle(
                    color: AppColor.blackText, fontWeight: FontWeight.bold),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

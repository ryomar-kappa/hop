import 'package:flutter/material.dart';
import 'package:hop_client/app_color.dart';
import 'package:hop_client/model/enum.dart';
import 'package:hop_client/screen/quiz_page/quiz_page.dart';

void main() {
  runApp(const MaterialApp(
    title: 'HOP',
    home: TopPageView(),
  ));
}

class TopPageView extends StatefulWidget {
  const TopPageView({super.key});

  @override
  State<StatefulWidget> createState() => TopPageState();
}

class TopPageState extends State<TopPageView> {
  DifficultyLevel selectedDifficultLevel = DifficultyLevel.firstClass;
  QuizMode selectedQuizMode = QuizMode.ten;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Murecho'),
      home: Scaffold(
        backgroundColor: AppColor.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _difficulityLevelSegmentButton(),
            const SizedBox(height: 64),
            _quizModeSegmentedButton(),
            const SizedBox(height: 64),
            Center(child: _startButton(context))
          ],
        ),
      ),
    );
  }

  SegmentedButton<QuizMode> _quizModeSegmentedButton() {
    return SegmentedButton(
      segments: QuizMode.values
          .map(
            (e) => ButtonSegment(value: e, icon: Text('${e.num}問')),
          )
          .toList(),
      selected: {selectedQuizMode},
      onSelectionChanged: (selected) {
        setState(() {
          selectedQuizMode = selected.first;
        });
      },
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
          backgroundColor: AppColor.nonSelectionColor,
          foregroundColor: AppColor.blackText,
          textStyle: const TextStyle(color: AppColor.whiteText),
          selectedForegroundColor: AppColor.blackText,
          selectedBackgroundColor: AppColor.selectionColor),
    );
  }

  SegmentedButton<DifficultyLevel> _difficulityLevelSegmentButton() {
    return SegmentedButton(
      segments: DifficultyLevel.values
          .map(
            (e) => ButtonSegment(value: e, icon: Text(e.jaName)),
          )
          .toList(),
      selected: {selectedDifficultLevel},
      onSelectionChanged: (selected) {
        setState(() {
          selectedDifficultLevel = selected.first;
        });
      },
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
          backgroundColor: AppColor.nonSelectionColor,
          foregroundColor: AppColor.blackText,
          textStyle: const TextStyle(color: AppColor.whiteText),
          selectedForegroundColor: AppColor.blackText,
          selectedBackgroundColor: AppColor.selectionColor),
    );
  }

  Widget _startButton(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                // FIXME: 画面にモード選択が追加されたら修正.
                builder: (context) => QuizLoadingView(
                      mode: selectedQuizMode,
                      difficultyLevel: selectedDifficultLevel,
                    )));
      },
      // FIXME: ボタン系は役割に応じて共通化.
      style: FilledButton.styleFrom(
        backgroundColor: AppColor.mainButton,
      ),
      child: const Text(
        'クイズスタート',
        style: TextStyle(color: AppColor.whiteText),
      ),
    );
  }
}

enum DifficultyLevel {
  firstClass('1級', 1),
  secondClass('2級', 2),
  thirdClass('3級', 3);

  final String jaName;
  final int level;

  const DifficultyLevel(this.jaName, this.level);
}

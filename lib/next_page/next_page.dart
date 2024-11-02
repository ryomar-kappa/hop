import 'package:flutter/material.dart';
import 'package:hop_client/app_color.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.headerColor,
        title: Text(
          '問題',
          style: TextStyle(color: AppColor.textColor),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: AppColor.backgroundColor,
          child: Column(
            children: [
              Expanded(
                child: QuizArea(),
              ),
              ChoisesArea(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoisesArea extends StatelessWidget {
  const ChoisesArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Choises(
          prefix: 'A',
          choise: 'ホップ',
        ),
        Choises(
          prefix: 'B',
          choise: 'モルト',
        ),
        Choises(
          prefix: 'C',
          choise: '酵母',
        ),
        Choises(
          prefix: 'D',
          choise: '水',
        ),
      ],
    );
  }
}

class QuizArea extends StatelessWidget {
  const QuizArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Text('1.ビールの原材料のうち「ビールの魂」と呼ばれるものはどれ？'),
      ],
    );
  }
}

class ChoisesState extends State<Choises> {
  final String prefix;
  final String choise;

  Color backGroundColor = AppColor.quizBackground;

  ChoisesState({required this.prefix, required this.choise});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          backGroundColor = AppColor.correctAnswerColor;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Text(prefix),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                choise,
                style: TextStyle(color: AppColor.quizText),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Choises extends StatefulWidget {
  const Choises({super.key, required this.prefix, required this.choise});

  final String prefix;
  final String choise;

  @override
  State<StatefulWidget> createState() {
    return ChoisesState(prefix: prefix, choise: choise);
  }
}

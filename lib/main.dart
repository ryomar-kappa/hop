import 'package:flutter/material.dart';
import 'package:hop_client/app_color.dart';
import 'package:hop_client/model/enum.dart';
import 'package:hop_client/screen/quiz_page/quiz_page.dart';

void main() {
  runApp(const MaterialApp(
    title: 'HOP',
    home: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Murecho'),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FilledButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          // FIXME: 画面にモード選択が追加されたら修正.
                          builder: (context) =>
                              const QuizLoadingView(mode: QuizMode.thirty)));
                },
                // FIXME: ボタン系は役割に応じて共通化.
                style: FilledButton.styleFrom(
                  backgroundColor: AppColor.mainButton,
                ),
                child: const Text(
                  'クイズスタート!!',
                  style: TextStyle(color: AppColor.buttonText),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

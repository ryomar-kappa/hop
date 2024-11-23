import 'package:flutter/material.dart';
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
                              builder: (context) => QuizPageView()));
                    },
                    child: const Text('クイズスタート!!')))
          ],
        ),
      ),
    );
  }
}

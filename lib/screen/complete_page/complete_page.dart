import 'package:flutter/material.dart';
import 'package:hop_client/main.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FilledButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainApp()), // ホーム画面への遷移
                      (Route<dynamic> route) => false, // スタック上の他のすべての画面を削除
                    );
                  },
                  child: const Text('ホーム画面に戻る')),
            )
          ],
        ),
      ),
    );
  }
}

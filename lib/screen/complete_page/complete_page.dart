import 'package:flutter/material.dart';

class CompletePage extends StatelessWidget {
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
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text('ホーム画面に戻る')),
            )
          ],
        ),
      ),
    );
  }
}

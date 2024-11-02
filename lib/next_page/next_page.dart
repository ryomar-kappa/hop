import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('次のページ'),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('戻る'))
          ],
        ),
      ),
    );
  }
}

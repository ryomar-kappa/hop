enum ChoicePrefix {
  a('A'),
  b('B'),
  c('C'),
  d('D');

  final String text;

  const ChoicePrefix(this.text);

  factory ChoicePrefix.fromIndex(int index) {
    switch (index) {
      case 0:
        return ChoicePrefix.a;
      case 1:
        return ChoicePrefix.b;
      case 2:
        return ChoicePrefix.c;
      case 3:
        return ChoicePrefix.d;
      case _:
        throw UnsupportedError('想定していない選択肢');
    }
  }
}

enum QuizMode {
  ten(10),
  thirty(30),
  fifty(50),
  hundred(100);

  final int num;

  const QuizMode(this.num);
}

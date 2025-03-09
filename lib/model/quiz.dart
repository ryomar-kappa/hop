class Quiz {
  final String question;
  final List<Choice> choices;
  final String explanation;
  final int level;

  Quiz(
      {required this.question,
      required this.choices,
      required this.explanation,
      required this.level});
}

class Choice {
  final String value;
  final bool answer;

  Choice({required this.value, required this.answer});
}

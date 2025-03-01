class Quiz {
  final String question;
  final List<Choice> choices;
  final String explanation;

  Quiz({
    required this.question,
    required this.choices,
    required this.explanation,
  });
}

class Choice {
  final String value;
  final bool answer;

  Choice({required this.value, required this.answer});
}

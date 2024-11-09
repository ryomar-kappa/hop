class Quiz {
  final String question;
  final List<String> choises;
  final int correctAnswer;
  final String explanation;

  Quiz(
      {required this.question,
      required this.choises,
      required this.correctAnswer,
      required this.explanation});
}

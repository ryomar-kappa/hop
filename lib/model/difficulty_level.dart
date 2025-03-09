enum DifficultyLevel {
  firstClass('1級', 1),
  secondClass('2級', 2),
  thirdClass('3級', 3);

  final String jaName;
  final int level;

  const DifficultyLevel(this.jaName, this.level);
}

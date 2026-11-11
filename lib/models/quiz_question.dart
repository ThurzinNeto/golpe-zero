class QuizQuestion {
  const QuizQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.topic,
  });

  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String topic;
}

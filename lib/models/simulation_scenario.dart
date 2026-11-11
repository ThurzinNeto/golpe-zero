class SimulationScenario {
  const SimulationScenario({
    required this.title,
    required this.channel,
    required this.icon,
    required this.message,
    required this.warningSigns,
    required this.safeAnswer,
    required this.explanation,
  });

  final String title;
  final String channel;
  final String icon;
  final String message;
  final List<String> warningSigns;
  final int safeAnswer;
  final String explanation;
}

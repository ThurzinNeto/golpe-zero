enum RiskLevel { low, medium, high }

class AnalysisFinding {
  const AnalysisFinding({
    required this.title,
    required this.description,
    required this.weight,
  });

  final String title;
  final String description;
  final int weight;
}

class ScamAnalysis {
  const ScamAnalysis({
    required this.level,
    required this.findings,
  });

  final RiskLevel level;
  final List<AnalysisFinding> findings;

  String get levelLabel => switch (level) {
        RiskLevel.low => 'Poucos sinais encontrados',
        RiskLevel.medium => 'Atenção: sinais suspeitos',
        RiskLevel.high => 'Alto risco de golpe',
      };
}

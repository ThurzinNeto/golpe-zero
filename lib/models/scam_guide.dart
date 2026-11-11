class ScamGuide {
  const ScamGuide({
    required this.name,
    required this.category,
    required this.icon,
    required this.summary,
    required this.howItWorks,
    required this.warningSigns,
    required this.protection,
    required this.ifVictim,
  });

  final String name;
  final String category;
  final String icon;
  final String summary;
  final String howItWorks;
  final List<String> warningSigns;
  final List<String> protection;
  final List<String> ifVictim;
}

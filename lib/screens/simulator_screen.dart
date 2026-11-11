import 'package:flutter/material.dart';

import '../data/educational_content.dart';
import '../models/simulation_scenario.dart';
import '../theme/app_theme.dart';
import '../widgets/content_layout.dart';

class SimulatorScreen extends StatefulWidget {
  const SimulatorScreen({super.key});

  @override
  State<SimulatorScreen> createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen> {
  int _scenarioIndex = 0;
  int? _choice;

  void _selectScenario(int index) {
    setState(() {
      _scenarioIndex = index;
      _choice = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scenario = simulationScenarios[_scenarioIndex];
    return ContentLayout(
      maxWidth: 960,
      children: [
        const PageHeading(
          eyebrow: 'Treine sem riscos',
          title: 'Simulador de situações',
          description:
              'Leia exemplos fictícios e escolha o que faria. Nenhuma situação ou conversa é real.',
        ),
        const SectionTitle('Escolha uma situação'),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 700 ? 3 : 2;
            final itemWidth =
                (constraints.maxWidth - ((columns - 1) * 10)) / columns;
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var index = 0; index < simulationScenarios.length; index++)
                  SizedBox(
                    width: itemWidth,
                    child: _ScenarioChip(
                      scenario: simulationScenarios[index],
                      selected: index == _scenarioIndex,
                      onTap: () => _selectScenario(index),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        _ConversationCard(
          scenario: scenario,
          selectedChoice: _choice,
          onChoose: (choice) => setState(() => _choice = choice),
        ),
        if (_choice != null) ...[
          const SizedBox(height: 16),
          _SimulationFeedback(
            scenario: scenario,
            safeChoice: _choice == scenario.safeAnswer,
          ),
        ],
        const SizedBox(height: 18),
        const Text(
          'As mensagens deste simulador são exemplos inventados para fins educativos.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.muted, fontSize: 12),
        ),
      ],
    );
  }
}

class _ScenarioChip extends StatelessWidget {
  const _ScenarioChip({
    required this.scenario,
    required this.selected,
    required this.onTap,
  });

  final SimulationScenario scenario;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppTheme.blue : AppTheme.muted;
    return Material(
      color: selected ? const Color(0xFFEAF2FF) : Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: selected ? AppTheme.blue : const Color(0xFFE1E8F0),
            ),
          ),
          child: Row(
            children: [
              Icon(iconByName[scenario.icon], color: color, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  scenario.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? AppTheme.ink : AppTheme.muted,
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConversationCard extends StatelessWidget {
  const _ConversationCard({
    required this.scenario,
    required this.selectedChoice,
    required this.onChoose,
  });

  final SimulationScenario scenario;
  final int? selectedChoice;
  final ValueChanged<int> onChoose;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFE8F6F2),
                  child:
                      Icon(Icons.person_outline_rounded, color: AppTheme.teal),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(scenario.channel,
                          style: Theme.of(context).textTheme.titleMedium),
                      const Text(
                        'EXEMPLO FICTÍCIO',
                        style: TextStyle(
                          color: AppTheme.teal,
                          fontSize: 10,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(iconByName[scenario.icon], color: AppTheme.muted),
              ],
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 650),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F5F9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Text(
                  scenario.message,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'O que você faria?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _ChoiceButton(
              selected: selectedChoice == 0,
              text: 'Seguiria o pedido da mensagem.',
              icon: Icons.touch_app_outlined,
              onTap: () => onChoose(0),
            ),
            const SizedBox(height: 10),
            _ChoiceButton(
              selected: selectedChoice == 1,
              text: 'Pararia e confirmaria por um canal oficial.',
              icon: Icons.verified_user_outlined,
              onTap: () => onChoose(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    required this.selected,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final bool selected;
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(15),
        foregroundColor: selected ? AppTheme.blue : AppTheme.ink,
        side: BorderSide(
          color: selected ? AppTheme.blue : const Color(0xFFE1E8F0),
          width: selected ? 1.5 : 1,
        ),
        backgroundColor: selected ? const Color(0xFFEAF2FF) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _SimulationFeedback extends StatelessWidget {
  const _SimulationFeedback({
    required this.scenario,
    required this.safeChoice,
  });

  final SimulationScenario scenario;
  final bool safeChoice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InfoCallout(
          title: safeChoice
              ? 'Boa escolha: confirme antes de agir'
              : 'Pare e verifique antes de agir',
          message: scenario.explanation,
          icon: safeChoice
              ? Icons.check_circle_outline_rounded
              : Icons.warning_amber_rounded,
          color: safeChoice ? AppTheme.teal : const Color(0xFFCF8A27),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('Sinais de alerta neste exemplo'),
                BulletList(items: scenario.warningSigns),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

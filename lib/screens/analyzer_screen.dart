import 'package:flutter/material.dart';

import '../models/scam_analysis.dart';
import '../services/scam_analyzer.dart';
import '../theme/app_theme.dart';
import '../widgets/content_layout.dart';

class AnalyzerScreen extends StatefulWidget {
  const AnalyzerScreen({super.key});

  @override
  State<AnalyzerScreen> createState() => _AnalyzerScreenState();
}

class _AnalyzerScreenState extends State<AnalyzerScreen> {
  final _controller = TextEditingController();
  final _analyzer = const ScamAnalyzer();
  ScamAnalysis? _result;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _analyze() {
    if (_controller.text.trim().isEmpty) {
      setState(() {
        _error = 'Cole ou digite uma mensagem para começar a análise.';
        _result = null;
      });
      return;
    }
    setState(() {
      _error = null;
      _result = _analyzer.analyze(_controller.text);
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      _result = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContentLayout(
      maxWidth: 860,
      children: [
        const PageHeading(
          eyebrow: 'Ferramenta educativa',
          title: 'Analisador de mensagens',
          description:
              'Cole uma mensagem ou link suspeito. Vamos apontar sinais que merecem sua atenção.',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(Icons.content_paste_search_rounded,
                        color: AppTheme.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'O que você recebeu?',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _clear,
                      icon: const Icon(Icons.delete_outline_rounded, size: 19),
                      label: const Text('Limpar'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  key: const ValueKey('analyzer-input'),
                  controller: _controller,
                  maxLines: 7,
                  maxLength: 2000,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    hintText:
                        'Ex.: Sua conta será bloqueada. Acesse este link e confirme seu código...',
                    errorText: _error,
                    alignLabelWithHint: true,
                  ),
                  onChanged: (_) {
                    if (_error != null || _result != null) {
                      setState(() {
                        _error = null;
                        _result = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _analyze,
                  icon: const Icon(Icons.manage_search_rounded),
                  label: const Text('Analisar sinais'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                ),
                const SizedBox(height: 12),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lock_outline_rounded,
                        size: 17, color: AppTheme.teal),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'A análise acontece neste dispositivo. O texto não é enviado nem salvo.',
                        style: TextStyle(color: AppTheme.muted, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_result case final result?) ...[
          const SizedBox(height: 18),
          _AnalysisResultCard(result: result),
        ],
        const SizedBox(height: 18),
        const InfoCallout(
          title: 'Importante: o resultado é indicativo',
          message:
              'Poucos sinais encontrados não significam que uma mensagem ou link seja seguro. Não clique em links inesperados nem compartilhe senhas ou códigos.',
          icon: Icons.warning_amber_rounded,
          color: Color(0xFFCB8632),
        ),
      ],
    );
  }
}

class _AnalysisResultCard extends StatelessWidget {
  const _AnalysisResultCard({required this.result});

  final ScamAnalysis result;

  @override
  Widget build(BuildContext context) {
    final color = switch (result.level) {
      RiskLevel.low => AppTheme.teal,
      RiskLevel.medium => const Color(0xFFCF8A27),
      RiskLevel.high => const Color(0xFFC84553),
    };
    final icon = switch (result.level) {
      RiskLevel.low => Icons.info_outline_rounded,
      RiskLevel.medium => Icons.warning_amber_rounded,
      RiskLevel.high => Icons.gpp_bad_outlined,
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.levelLabel,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: color,
                            ),
                      ),
                      const Text(
                        'Resultado indicativo, não uma confirmação de segurança.',
                        style: TextStyle(color: AppTheme.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              result.findings.isEmpty
                  ? 'Não encontramos os sinais previstos nas regras desta versão. Ainda assim, confirme por um canal oficial antes de agir.'
                  : 'Sinais identificados nesta mensagem:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (result.findings.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 14),
                child: _FindingRow(
                  title: 'Nenhum sinal previsto foi detectado',
                  description:
                      'Golpes podem não conter as características verificadas por esta ferramenta.',
                  color: AppTheme.muted,
                ),
              )
            else ...[
              const SizedBox(height: 12),
              for (final finding in result.findings)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _FindingRow(
                    title: finding.title,
                    description: finding.description,
                    color: color,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FindingRow extends StatelessWidget {
  const _FindingRow({
    required this.title,
    required this.description,
    required this.color,
  });

  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline_rounded, color: color, size: 19),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 3),
              Text(description, style: const TextStyle(color: AppTheme.muted)),
            ],
          ),
        ),
      ],
    );
  }
}

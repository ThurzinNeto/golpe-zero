import '../models/scam_analysis.dart';

class ScamAnalyzer {
  const ScamAnalyzer();

  ScamAnalysis analyze(String input) {
    final text = _normalize(input);
    final findings = <AnalysisFinding>[];

    void addIf(bool matches, AnalysisFinding finding) {
      if (matches) findings.add(finding);
    }

    addIf(
      _containsAny(text, const [
        'urgente',
        'imediatamente',
        'ultima chance',
        'em poucos minutos',
        'hoje',
        'expira',
        'bloqueada',
        'bloqueado',
        'suspensa',
        'suspenso',
        'regularize agora',
        'prazo de 24 horas',
      ]),
      const AnalysisFinding(
        title: 'Pressão ou urgência',
        description:
            'A mensagem tenta apressar uma decisão com prazo, ameaça ou consequência imediata.',
        weight: 2,
      ),
    );

    addIf(
      _containsAny(text, const [
        'senha',
        'codigo de confirmacao',
        'codigo recebido',
        'token',
        'cvv',
        'codigo sms',
        'dados do cartao',
        'compartilhe sua tela',
      ]),
      const AnalysisFinding(
        title: 'Pedido de dado ou código sensível',
        description:
            'Mensagens que pedem senha, código de autenticação ou dados do cartão exigem cuidado especial.',
        weight: 4,
      ),
    );

    addIf(
      _containsAny(text, const [
        'pix',
        'chave pix',
        'transferencia',
        'faca um pagamento',
        'pague a taxa',
      ]),
      const AnalysisFinding(
        title: 'Pedido de pagamento ou transferência',
        description:
            'Há menção a Pix, transferência ou pagamento. Confirme qualquer cobrança por um canal independente.',
        weight: 2,
      ),
    );

    addIf(
      _containsAny(text, const [
        'voce ganhou',
        'premio',
        'dinheiro facil',
        'renda garantida',
        'clique e receba',
        'premiacao',
        'taxa de entrega',
      ]),
      const AnalysisFinding(
        title: 'Promessa de prêmio ou dinheiro fácil',
        description:
            'Prêmios inesperados e ganhos garantidos podem ser usados para atrair vítimas.',
        weight: 2,
      ),
    );

    final hasImpersonation = _containsAny(text, const [
      'banco',
      'correios',
      'receita federal',
      'serasa',
      'suporte tecnico',
      'central de seguranca',
      'sua conta',
    ]);
    addIf(
      hasImpersonation &&
          _containsAny(text, const [
            'confirme',
            'acesse',
            'informe',
            'regularize',
            'bloqueada',
            'bloqueado',
            'senha',
            'codigo',
            'pix',
          ]),
      const AnalysisFinding(
        title: 'Possível personificação de empresa',
        description:
            'A mensagem cita uma instituição e pede uma ação. Verifique diretamente nos canais oficiais.',
        weight: 2,
      ),
    );

    final linkFinding = _inspectLinks(input, text);
    if (linkFinding != null) findings.add(linkFinding);

    final score =
        findings.fold<int>(0, (total, finding) => total + finding.weight);
    final level = score >= 5
        ? RiskLevel.high
        : score >= 2
            ? RiskLevel.medium
            : RiskLevel.low;
    return ScamAnalysis(level: level, findings: findings);
  }

  AnalysisFinding? _inspectLinks(String original, String normalized) {
    final links = RegExp(
      r'(?<![@\w])(?:(?:https?:\/\/|www\.)[^\s]+|(?:[\w-]+\.)+[a-z]{2,}(?::\d+)?(?:\/[^\s]*)?)',
      caseSensitive: false,
    )
        .allMatches(original)
        .map((match) => match.group(0)!.replaceFirst(RegExp(r'[.,!?;:]+$'), ''))
        .where((link) => link.isNotEmpty)
        .toList();
    if (links.isEmpty) return null;

    final suspiciousDomains = <String>[
      'bit.ly',
      'tinyurl.com',
      't.co',
      'cutt.ly',
      'is.gd',
      'rebrand.ly',
      'rb.gy',
    ];
    var suspicious = false;
    for (final link in links) {
      final candidate = link.startsWith('www.') || !link.contains('://')
          ? 'https://$link'
          : link;
      final uri = Uri.tryParse(candidate);
      final host = uri?.host.toLowerCase() ?? '';
      if (host.isEmpty ||
          suspiciousDomains
              .any((domain) => host == domain || host.endsWith('.$domain')) ||
          host.split('.').any((part) => part.startsWith('xn--')) ||
          RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(host) ||
          uri?.userInfo.isNotEmpty == true) {
        suspicious = true;
      }
    }
    if (!suspicious &&
        _containsAny(normalized, const [
          'confirme sua conta',
          'informe seus dados',
          'senha',
          'codigo sms',
        ])) {
      suspicious = true;
    }
    return AnalysisFinding(
      title: suspicious
          ? 'Link que merece verificação'
          : 'Link incluído na mensagem',
      description: suspicious
          ? 'Há um link com características que merecem conferência. Não abra; acesse o serviço pelo endereço oficial.'
          : 'Um link foi identificado. Esta análise não confirma o destino nem garante que ele seja seguro.',
      weight: suspicious ? 3 : 1,
    );
  }

  bool _containsAny(String text, List<String> phrases) =>
      phrases.any(text.contains);

  String _normalize(String value) {
    var normalized = value.toLowerCase();
    const replacements = {
      'á': 'a',
      'à': 'a',
      'â': 'a',
      'ã': 'a',
      'ä': 'a',
      'é': 'e',
      'ê': 'e',
      'ë': 'e',
      'í': 'i',
      'ï': 'i',
      'ó': 'o',
      'ô': 'o',
      'õ': 'o',
      'ö': 'o',
      'ú': 'u',
      'ü': 'u',
      'ç': 'c',
    };
    for (final entry in replacements.entries) {
      normalized = normalized.replaceAll(entry.key, entry.value);
    }
    return normalized;
  }
}

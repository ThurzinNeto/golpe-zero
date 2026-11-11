import 'package:flutter_test/flutter_test.dart';
import 'package:golpe_zero/models/scam_analysis.dart';
import 'package:golpe_zero/services/scam_analyzer.dart';

void main() {
  const analyzer = ScamAnalyzer();

  test('classifica pedido urgente de código e Pix como alto risco', () {
    final result = analyzer.analyze(
      'Sua conta será bloqueada imediatamente. Informe o código SMS e faça um Pix.',
    );

    expect(result.level, RiskLevel.high);
    expect(
      result.findings.map((finding) => finding.title),
      containsAll([
        'Pressão ou urgência',
        'Pedido de dado ou código sensível',
        'Pedido de pagamento ou transferência',
      ]),
    );
  });

  test('reconhece links encurtados e não declara que são seguros', () {
    final result = analyzer.analyze('Confira agora: https://bit.ly/ganhe-ja');

    expect(result.level, RiskLevel.medium);
    expect(result.findings.single.title, 'Link que merece verificação');
  });

  test('detecta um endereço sem protocolo sem atestar segurança', () {
    final result = analyzer.analyze('Confira a oferta em loja-exemplo.com.br');

    expect(result.level, RiskLevel.low);
    expect(result.findings.single.title, 'Link incluído na mensagem');
    expect(result.findings.single.description, contains('nem garante'));
  });

  test('poucos sinais não são tratados como prova de segurança', () {
    final result = analyzer.analyze('Olá, tudo bem?');

    expect(result.level, RiskLevel.low);
    expect(result.findings, isEmpty);
  });

  test('localiza acentos e variações de urgência', () {
    final result = analyzer.analyze(
      'Sua conta será suspensa. Acesse para confirmar sua senha.',
    );

    expect(result.level, RiskLevel.high);
    expect(result.findings.map((finding) => finding.title),
        contains('Pedido de dado ou código sensível'));
  });
}

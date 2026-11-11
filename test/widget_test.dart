import 'package:flutter_test/flutter_test.dart';
import 'package:golpe_zero/app/golpe_zero_app.dart';

void main() {
  testWidgets('a tela inicial abre o analisador e valida texto vazio',
      (tester) async {
    await tester.pumpWidget(const GolpeZeroApp());

    expect(find.text('Desconfie. Confira.\nProteja-se.'), findsOneWidget);
    await tester.tap(find.text('Analisador').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Analisar sinais'));
    await tester.tap(find.text('Analisar sinais'));
    await tester.pumpAndSettle();

    expect(
      find.text('Cole ou digite uma mensagem para começar a análise.'),
      findsOneWidget,
    );
  });

  testWidgets('o quiz mostra explicação após a resposta', (tester) async {
    await tester.pumpWidget(const GolpeZeroApp());
    await tester.tap(find.text('Quiz').last);
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.text(
        'Não compartilhar e confirmar pelo aplicativo ou telefone oficial do banco',
      ),
    );
    final correctAnswer = find.text(
      'Não compartilhar e confirmar pelo aplicativo ou telefone oficial do banco',
    );
    await tester.tap(
      find.ancestor(of: correctAnswer, matching: find.byType(InkWell)).first,
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Conferir resposta'),
          )
          .onPressed,
      isNotNull,
    );
    await tester.ensureVisible(find.text('Conferir resposta'));
    await tester.tap(find.text('Conferir resposta'));
    await tester.pumpAndSettle();

    expect(find.text('Resposta correta!'), findsOneWidget);
    expect(find.textContaining('Bancos não precisam'), findsOneWidget);
  });
}

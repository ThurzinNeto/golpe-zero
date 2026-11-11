import 'package:flutter/material.dart';

import '../data/educational_content.dart';
import '../theme/app_theme.dart';
import '../widgets/content_layout.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int? _selectedIndex;
  int _score = 0;
  bool _answered = false;

  void _select(int index) {
    if (_answered) return;
    setState(() => _selectedIndex = index);
  }

  void _continue() {
    if (_selectedIndex == null) return;
    final question = quizQuestions[_questionIndex];
    setState(() {
      if (!_answered && _selectedIndex == question.correctIndex) _score++;
      if (_answered) {
        if (_questionIndex == quizQuestions.length - 1) {
          _questionIndex = quizQuestions.length;
        } else {
          _questionIndex++;
        }
        _selectedIndex = null;
        _answered = false;
      } else {
        _answered = true;
      }
    });
  }

  void _restart() {
    setState(() {
      _questionIndex = 0;
      _selectedIndex = null;
      _score = 0;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final complete = _questionIndex >= quizQuestions.length;
    return ContentLayout(
      maxWidth: 780,
      children: [
        PageHeading(
          eyebrow: 'Aprenda praticando',
          title: complete ? 'Seu resultado' : 'Quiz de segurança',
          description: complete
              ? 'Cada pergunta é uma chance de reconhecer um sinal de alerta.'
              : 'Responda no seu ritmo. Depois de cada escolha, veja uma explicação.',
          action: complete
              ? IconButton(
                  tooltip: 'Jogar novamente',
                  onPressed: _restart,
                  icon: const Icon(Icons.refresh_rounded),
                )
              : null,
        ),
        if (complete)
          _QuizResult(
            score: _score,
            total: quizQuestions.length,
            onRestart: _restart,
          )
        else
          _QuestionCard(
            questionIndex: _questionIndex,
            selectedIndex: _selectedIndex,
            answered: _answered,
            onSelect: _select,
            onContinue: _continue,
          ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.questionIndex,
    required this.selectedIndex,
    required this.answered,
    required this.onSelect,
    required this.onContinue,
  });

  final int questionIndex;
  final int? selectedIndex;
  final bool answered;
  final ValueChanged<int> onSelect;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[questionIndex];
    final correct = selectedIndex == question.correctIndex;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Pergunta ${questionIndex + 1} de ${quizQuestions.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  '${((questionIndex + 1) / quizQuestions.length * 100).round()}%',
                  style: const TextStyle(
                    color: AppTheme.blue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: (questionIndex + 1) / quizQuestions.length,
                minHeight: 8,
                backgroundColor: const Color(0xFFE8EEF6),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F6F2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                question.topic,
                style: const TextStyle(
                  color: AppTheme.teal,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(question.prompt,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 18),
            for (var index = 0; index < question.options.length; index++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AnswerOption(
                  text: question.options[index],
                  letter: String.fromCharCode(65 + index),
                  selected: selectedIndex == index,
                  correct: answered && index == question.correctIndex,
                  incorrect: answered &&
                      selectedIndex == index &&
                      index != question.correctIndex,
                  onTap: () => onSelect(index),
                ),
              ),
            if (answered) ...[
              const SizedBox(height: 8),
              InfoCallout(
                title:
                    correct ? 'Resposta correta!' : 'Vamos aprender com isso',
                message: question.explanation,
                icon: correct
                    ? Icons.check_circle_outline_rounded
                    : Icons.lightbulb_outline_rounded,
                color: correct ? AppTheme.teal : const Color(0xFFCF8A27),
              ),
            ],
            const SizedBox(height: 18),
            FilledButton(
              onPressed: selectedIndex == null ? null : onContinue,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text(answered
                  ? questionIndex == quizQuestions.length - 1
                      ? 'Ver resultado'
                      : 'Próxima pergunta'
                  : 'Conferir resposta'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
    required this.text,
    required this.letter,
    required this.selected,
    required this.correct,
    required this.incorrect,
    required this.onTap,
  });

  final String text;
  final String letter;
  final bool selected;
  final bool correct;
  final bool incorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = correct
        ? AppTheme.teal
        : incorrect
            ? const Color(0xFFC84553)
            : selected
                ? AppTheme.blue
                : const Color(0xFFE0E7F0);
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withValues(
                alpha: selected || correct || incorrect ? 0.08 : 0),
            border: Border.all(
                color: color,
                width: selected || correct || incorrect ? 1.4 : 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: color.withValues(alpha: 0.12),
                child: Text(
                  correct
                      ? '✓'
                      : incorrect
                          ? '!'
                          : letter,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(text)),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuizResult extends StatelessWidget {
  const _QuizResult({
    required this.score,
    required this.total,
    required this.onRestart,
  });

  final int score;
  final int total;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    final percentage = score / total;
    final title = percentage >= 0.8
        ? 'Você está atento!'
        : percentage >= 0.5
            ? 'Bom começo!'
            : 'Continue praticando!';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: const Color(0xFFE5F5F0),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.emoji_events_outlined,
                color: AppTheme.teal,
                size: 44,
              ),
            ),
            const SizedBox(height: 18),
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'Você acertou $score de $total perguntas.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 18),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: percentage,
                minHeight: 10,
                backgroundColor: const Color(0xFFE8EEF6),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Em situações reais, pare, confira por outro canal e nunca compartilhe senhas ou códigos.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.muted),
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Jogar novamente'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/content_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.onOpen, super.key});

  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 700;
    return ContentLayout(
      maxWidth: 1120,
      children: [
        Container(
          padding: EdgeInsets.all(wide ? 34 : 24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.navy, Color(0xFF1E4973)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -15,
                top: -25,
                child: Icon(
                  Icons.shield_rounded,
                  size: wide ? 210 : 120,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified_user_outlined,
                            color: Color(0xFF62E0C1), size: 16),
                        SizedBox(width: 7),
                        Text(
                          'MAIS CONHECIMENTO, MAIS PROTEÇÃO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'Desconfie. Confira.\nProteja-se.',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                                fontSize: wide ? 43 : 34,
                                height: 1.08,
                              ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      'Aprenda a reconhecer sinais de golpes digitais com ferramentas educativas e privadas.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.82),
                          ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => onOpen(1),
                    icon: const Icon(Icons.shield_outlined),
                    label: const Text('Analisar mensagem'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF28C7A4),
                      foregroundColor: AppTheme.navy,
                      minimumSize: const Size(190, 50),
                      textStyle: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    children: [
                      Icon(Icons.lock_outline,
                          color: Color(0xFF9FEBD8), size: 16),
                      SizedBox(width: 7),
                      Flexible(
                        child: Text(
                          'Análise local: seu texto não sai deste dispositivo.',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const SectionTitle(
          'Escolha por onde começar',
          subtitle:
              'Ferramentas simples para decisões mais seguras no dia a dia.',
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 760 ? 2 : 1;
            final cardWidth =
                (constraints.maxWidth - ((columns - 1) * 14)) / columns;
            return Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: FeatureCard(
                    title: 'Analisador de mensagens',
                    description:
                        'Veja sinais de alerta em textos e links suspeitos.',
                    icon: Icons.manage_search_rounded,
                    color: AppTheme.blue,
                    onTap: () => onOpen(1),
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: FeatureCard(
                    title: 'Quiz de segurança',
                    description:
                        'Teste seus conhecimentos e aprenda com cada resposta.',
                    icon: Icons.quiz_outlined,
                    color: const Color(0xFF8A61D5),
                    onTap: () => onOpen(2),
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: FeatureCard(
                    title: 'Simulador de situações',
                    description:
                        'Pratique identificar tentativas de golpe fictícias.',
                    icon: Icons.forum_outlined,
                    color: AppTheme.teal,
                    onTap: () => onOpen(3),
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: FeatureCard(
                    title: 'Biblioteca de golpes',
                    description:
                        'Conheça como os golpes acontecem e como se proteger.',
                    icon: Icons.menu_book_outlined,
                    color: const Color(0xFFE59B36),
                    onTap: () => onOpen(4),
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: FeatureCard(
                    title: 'Precisa de orientação?',
                    description:
                        'Saiba como agir e encontre canais oficiais de apoio.',
                    icon: Icons.health_and_safety_outlined,
                    color: const Color(0xFFDB6471),
                    onTap: () => onOpen(5),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 26),
        const InfoCallout(
          title: 'Uma análise não é uma garantia',
          message:
              'Nenhuma ferramenta automática consegue confirmar sozinha que uma mensagem ou um link é seguro. Na dúvida, não clique e procure a empresa por um canal oficial.',
          icon: Icons.lightbulb_outline_rounded,
          color: AppTheme.teal,
        ),
        const SizedBox(height: 22),
        Center(
          child: Text(
            'Conteúdo educativo • Sem envio de denúncias • Sem coleta de dados bancários',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.muted,
                ),
          ),
        ),
      ],
    );
  }
}

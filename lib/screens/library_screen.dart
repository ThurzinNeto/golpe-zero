import 'package:flutter/material.dart';

import '../data/educational_content.dart';
import '../models/scam_guide.dart';
import '../theme/app_theme.dart';
import '../widgets/content_layout.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    final guides = scamGuides.where((guide) {
      return guide.name.toLowerCase().contains(query) ||
          guide.category.toLowerCase().contains(query) ||
          guide.summary.toLowerCase().contains(query);
    }).toList();
    return ContentLayout(
      maxWidth: 1000,
      children: [
        const PageHeading(
          eyebrow: 'Informação para se proteger',
          title: 'Biblioteca de golpes',
          description:
              'Conheça como os golpes mais comuns funcionam, os sinais de alerta e os próximos passos.',
        ),
        TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search_rounded),
            hintText: 'Buscar por golpe ou categoria',
            suffixIcon: _query.isEmpty
                ? null
                : IconButton(
                    tooltip: 'Limpar busca',
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
          ),
        ),
        const SizedBox(height: 18),
        if (guides.isEmpty)
          const InfoCallout(
            title: 'Nenhum resultado encontrado',
            message: 'Tente outra palavra, como “Pix”, “loja” ou “banco”.',
            icon: Icons.search_off_rounded,
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 700 ? 2 : 1;
              final width =
                  (constraints.maxWidth - ((columns - 1) * 14)) / columns;
              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  for (final guide in guides)
                    SizedBox(
                      width: width,
                      child: _GuideCard(
                        guide: guide,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ScamDetailScreen(guide: guide),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
      ],
    );
  }
}

class _GuideCard extends StatelessWidget {
  const _GuideCard({required this.guide, required this.onTap});

  final ScamGuide guide;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF2FF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      iconByName[guide.icon],
                      color: AppTheme.blue,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    guide.category,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.teal,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(guide.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 7),
              Text(
                guide.summary,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.muted,
                    ),
              ),
              const SizedBox(height: 14),
              const Row(
                children: [
                  Text(
                    'Ver como se proteger',
                    style: TextStyle(
                      color: AppTheme.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_forward_rounded,
                      color: AppTheme.blue, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScamDetailScreen extends StatelessWidget {
  const ScamDetailScreen({required this.guide, super.key});

  final ScamGuide guide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guia de prevenção'),
        leading: IconButton(
          tooltip: 'Voltar',
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: ContentLayout(
        maxWidth: 850,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.navy, Color(0xFF1E4973)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Icon(iconByName[guide.icon], color: Colors.white, size: 35),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        guide.category.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF8FE5CE),
                          fontSize: 11,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        guide.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 23,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _DetailSection(title: 'Como funciona', child: Text(guide.howItWorks)),
          _DetailSection(
            title: 'Principais sinais de alerta',
            child: BulletList(items: guide.warningSigns),
          ),
          _DetailSection(
            title: 'Como se proteger',
            child: BulletList(items: guide.protection),
          ),
          _DetailSection(
            title: 'Se você foi vítima',
            child: BulletList(items: guide.ifVictim),
          ),
          const InfoCallout(
            title: 'Não precisa resolver sozinho',
            message:
                'Fale com seu banco ou com uma pessoa de confiança usando contatos oficiais. Não compartilhe senhas ou códigos para pedir ajuda.',
            icon: Icons.support_agent_rounded,
            color: AppTheme.teal,
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

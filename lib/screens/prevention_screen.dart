import 'package:flutter/material.dart';

import '../data/educational_content.dart';
import '../services/official_link_service.dart';
import '../theme/app_theme.dart';
import '../widgets/content_layout.dart';

class PreventionScreen extends StatelessWidget {
  const PreventionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentLayout(
      maxWidth: 900,
      children: [
        const PageHeading(
          eyebrow: 'Apoio para agir com calma',
          title: 'Prevenção e próximos passos',
          description:
              'Se recebeu uma tentativa de golpe ou já fez uma transferência, priorize sua segurança e procure os canais certos.',
        ),
        _ActionSection(
          number: '01',
          title: 'Recebeu uma tentativa de golpe?',
          icon: Icons.pause_circle_outline_rounded,
          color: AppTheme.blue,
          steps: const [
            'Não clique em links, não responda e não compartilhe senhas ou códigos.',
            'Confirme a informação ligando para a empresa pelo número do cartão ou aplicativo oficial.',
            'Bloqueie e denuncie o contato na plataforma em que recebeu a mensagem.',
            'Se houver ameaça imediata, procure ajuda de uma pessoa de confiança e os serviços públicos adequados.',
          ],
        ),
        _ActionSection(
          number: '02',
          title: 'Fez uma transferência ou compartilhou dados?',
          icon: Icons.emergency_outlined,
          color: const Color(0xFFC84553),
          steps: const [
            'Contate imediatamente seu banco pelo aplicativo ou telefone oficial e explique o que aconteceu.',
            'Peça o bloqueio de acessos e cartões se necessário e pergunte como contestar a operação.',
            'Para Pix, solicite ao banco a análise pelos mecanismos disponíveis, como o MED quando aplicável. O pedido não garante devolução.',
            'Se compartilhou senha, troque-a pelo aplicativo oficial e revise outros acessos que usem a mesma senha.',
          ],
        ),
        _ActionSection(
          number: '03',
          title: 'Guarde evidências e registre',
          icon: Icons.folder_copy_outlined,
          color: AppTheme.teal,
          steps: const [
            'Guarde mensagens, números, endereços de sites, comprovantes, datas e protocolos de atendimento.',
            'Registre ocorrência na Polícia Civil ou na delegacia virtual disponível no seu estado.',
            'Não apague conversas importantes nem publique seus dados pessoais ou bancários.',
            'Contate o banco para acompanhar a contestação e anote os protocolos.',
          ],
        ),
        const SizedBox(height: 6),
        const SectionTitle(
          'Canais oficiais de informação',
          subtitle:
              'Os links abaixo abrem sites externos. Confira sempre o endereço antes de informar qualquer dado.',
        ),
        for (final resource in officialResources)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ResourceCard(
              title: resource.title,
              subtitle: resource.subtitle,
              onTap: () => OfficialLinkService.open(context, resource.url),
            ),
          ),
        const SizedBox(height: 6),
        const InfoCallout(
          title: 'O GolpeZero não recebe denúncias',
          message:
              'Este aplicativo é educativo. Nenhum dado ou denúncia é enviado. Para relatar uma situação, procure os canais oficiais indicados acima ou as autoridades da sua região.',
          icon: Icons.privacy_tip_outlined,
          color: AppTheme.teal,
        ),
      ],
    );
  }
}

class _ActionSection extends StatelessWidget {
  const _ActionSection({
    required this.number,
    required this.title,
    required this.icon,
    required this.color,
    required this.steps,
  });

  final String number;
  final String title;
  final IconData icon;
  final Color color;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(title,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Text(
                  number,
                  style: TextStyle(
                    color: color.withValues(alpha: 0.65),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            for (var index = 0; index < steps.length; index++)
              Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0F4F8),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: AppTheme.muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(steps[index])),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  const _ResourceCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFEAF2FF),
          child:
              Icon(Icons.open_in_new_rounded, color: AppTheme.blue, size: 19),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ),
    );
  }
}

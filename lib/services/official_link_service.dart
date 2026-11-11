import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficialLinkService {
  static Future<void> open(BuildContext context, String value) async {
    final uri = Uri.tryParse(value);
    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      _showError(context);
      return;
    }
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) _showError(context);
  }

  static void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Não foi possível abrir o link. Tente novamente pelo navegador.'),
      ),
    );
  }
}

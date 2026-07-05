import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  /// Retorna false se não foi possível abrir o WhatsApp.
  static Future<bool> openWhatsApp(String phone) async {
    // Remove tudo que não for número
    String digits = phone.replaceAll(RegExp(r'\D'), '');

    // Se já vier com DDI 55, mantém
    // Se não vier, adiciona o 55 do Brasil
    if (!digits.startsWith('55')) {
      digits = '55$digits';
    }

    final message = Uri.encodeComponent(
        'Olá! Vi seu item no AdianteDoe+ e tenho interesse!'
    );

    final url = Uri.parse('https://wa.me/$digits?text=$message');

    // canLaunchUrl dá falso negativo em Android 11+; tenta abrir direto
    try {
      return await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  static Future<void> openWhatsApp(String phone) async {
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

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
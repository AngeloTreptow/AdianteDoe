import 'package:flutter/material.dart';

// Tela estática: explica o objetivo do app. Sem Firebase e sem estado.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o app'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.volunteer_activism,
                      size: 64, color: Colors.green[700]),
                  const SizedBox(height: 12),
                  const Text(
                    'AdianteDoe+',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'O AdianteDoe+ conecta quem quer doar com quem precisa. '
              'A ideia é simples: dar uma nova vida a itens que estão parados, '
              'fortalecendo o reaproveitamento e a solidariedade na comunidade.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            const Text(
              'Como funciona',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const _Step(
              icon: Icons.add_a_photo_outlined,
              text: 'Quem doa publica o item com foto e WhatsApp de contato — '
                  'sem cadastro e sem custo.',
            ),
            const _Step(
              icon: Icons.chat_outlined,
              text: 'Quem se interessa fala direto com o doador pelo WhatsApp '
                  'e combina a retirada.',
            ),
            const _Step(
              icon: Icons.schedule_outlined,
              text: 'Cada anúncio fica no ar por 14 dias e depois sai da '
                  'lista automaticamente.',
            ),
            const _Step(
              icon: Icons.flag_outlined,
              text: 'Viu algo errado? Use o botão de denúncia no anúncio para '
                  'avisar a moderação.',
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                border: Border.all(color: Colors.amber),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'O AdianteDoe+ apenas aproxima as pessoas: a combinação e a '
                'entrega da doação acontecem diretamente entre doador e '
                'interessado.',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Step({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.green[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 15, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

// Tela estática: diretrizes de uso e de conteúdo. Além de orientar a
// comunidade, atende a política de UGC do Google Play, que pede regras de
// conteúdo publicadas em apps com conteúdo gerado por usuários.
class CommunityRulesScreen extends StatelessWidget {
  const CommunityRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regras da comunidade'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'O AdianteDoe+ é um espaço de doação. Para manter a comunidade '
              'segura e acolhedora, siga estas diretrizes.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            const _SectionTitle('✅ O que pode ser doado'),
            const _Rule('Itens em condições de uso: roupas, móveis, '
                'eletrodomésticos, livros, brinquedos, utensílios.'),
            const _Rule('Itens com pequenos defeitos, desde que o defeito '
                'seja informado no anúncio.'),
            const SizedBox(height: 16),
            const _SectionTitle('🚫 O que não pode'),
            const _Rule('Venda ou troca — aqui é só doação, sem pedir nada '
                'em troca.'),
            const _Rule('Medicamentos, bebidas alcoólicas, cigarros e '
                'produtos vencidos.'),
            const _Rule('Armas, itens perigosos ou de origem ilegal.'),
            const _Rule('Animais.'),
            const _Rule('Conteúdo ofensivo, golpes ou anúncios com telefone '
                'falso.'),
            const SizedBox(height: 16),
            const _SectionTitle('🤝 Boas práticas'),
            const _Rule('Use fotos reais do item que está doando.'),
            const _Rule('Descreva o estado do item com honestidade.'),
            const _Rule('Combine a retirada em local seguro e, se possível, '
                'público.'),
            const _Rule('Responda no WhatsApp quem se interessar, mesmo que '
                'o item já tenha sido doado.'),
            const _Rule('Viu um anúncio que quebra estas regras? Denuncie '
                'pelo botão 🚩 no próprio anúncio.'),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                border: Border.all(color: Colors.amber),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Anúncios denunciados são revisados e podem ser removidos '
                'sem aviso. O conteúdo publicado é de responsabilidade de '
                'quem publica.',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  final String text;
  const _Rule(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(fontSize: 15, height: 1.4)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 15, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/firebase_service.dart';
import '../widgets/item_card.dart';
import 'about_screen.dart';
import 'add_item_screen.dart';
import 'community_rules_screen.dart';
import 'feedback_screen.dart';

// Página pública com a política de privacidade do app
const _privacyPolicyUrl = 'https://angelotreptow.github.io/AdianteDoe/';

// Opções do menu da AppBar
enum _MenuOption { about, communityRules, feedback, privacyPolicy }

class HomeScreen extends StatefulWidget {
  // Injetável para permitir fakes em testes; se omitido, usa o Firebase real
  final FirebaseService? service;
  const HomeScreen({super.key, this.service});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Stream criado uma única vez — recriar no build abriria um novo listener a cada rebuild
  late final _itemsStream = (widget.service ?? FirebaseService()).getItems();

  void _pushScreen(Widget screen) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));

  // Abre a política no navegador externo. Sem canLaunchUrl, que dá falso
  // negativo em Android 11+: tenta abrir direto, como no WhatsAppService
  Future<void> _openPrivacyPolicy() async {
    bool opened;
    try {
      opened = await launchUrl(
        Uri.parse(_privacyPolicyUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      // Log para diagnóstico; a UI mostra só a mensagem
      debugPrint('Falha ao abrir a política de privacidade: $e');
      opened = false;
    }
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir a política de privacidade.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdianteDoe+'),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<_MenuOption>(
            tooltip: 'Menu',
            onSelected: (option) => switch (option) {
              _MenuOption.about => _pushScreen(const AboutScreen()),
              _MenuOption.communityRules =>
                _pushScreen(const CommunityRulesScreen()),
              _MenuOption.feedback =>
                _pushScreen(FeedbackScreen(service: widget.service)),
              // Não abre tela: vai direto para o navegador externo
              _MenuOption.privacyPolicy => _openPrivacyPolicy(),
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: _MenuOption.about,
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Sobre o app'),
                ),
              ),
              PopupMenuItem(
                value: _MenuOption.communityRules,
                child: ListTile(
                  leading: Icon(Icons.gavel_outlined),
                  title: Text('Regras da comunidade'),
                ),
              ),
              PopupMenuItem(
                value: _MenuOption.feedback,
                child: ListTile(
                  leading: Icon(Icons.lightbulb_outline),
                  title: Text('Enviar sugestão'),
                ),
              ),
              PopupMenuItem(
                value: _MenuOption.privacyPolicy,
                child: ListTile(
                  leading: Icon(Icons.privacy_tip_outlined),
                  title: Text('Política de Privacidade'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _itemsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Não foi possível carregar os itens.\nVerifique sua conexão e tente novamente.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum item disponível.\nSeja o primeiro a doar! 🎁',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          final items = snapshot.data!;
          return ListView.builder(
            // Respiro no fim da lista: sem ele, o FAB "Doar item" cobre o
            // botão de contato do último card quando a lista rola
            padding: const EdgeInsets.only(bottom: 88),
            itemCount: items.length,
            itemBuilder: (_, i) =>
                ItemCard(item: items[i], service: widget.service),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddItemScreen()),
        ),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Doar item'),
      ),
    );
  }
}
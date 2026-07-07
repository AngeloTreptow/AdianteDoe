import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/firebase_service.dart';
import '../services/whatsapp_service.dart';
import '../widgets/report_button.dart';

// Detalhe de uma doação: foto ampliada (com zoom por pinça), descrição
// completa e as mesmas ações do card (contato e denúncia).
class ItemDetailScreen extends StatelessWidget {
  final ItemModel item;
  // Injetável para permitir fakes em testes; se omitido, usa o Firebase real
  final FirebaseService? service;
  const ItemDetailScreen({super.key, required this.item, this.service});

  String get _publishedDate {
    final d = item.createdAt;
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final description = item.description?.trim();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da doação'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          ReportButton(itemId: item.id, service: service, color: Colors.white),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.imageUrl != null)
              // Zoom por pinça na foto, sem abrir outra tela
              InteractiveViewer(
                maxScale: 4,
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl!,
                  width: double.infinity,
                  height: 320,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 320,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 320,
                    color: Colors.grey[200],
                    child: const Center(
                      child:
                          Icon(Icons.broken_image, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Publicado em $_publishedDate',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Descrição',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    (description == null || description.isEmpty)
                        ? 'O doador não adicionou uma descrição.'
                        : description,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: (description == null || description.isEmpty)
                          ? Colors.grey
                          : null,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final opened =
                            await WhatsAppService.openWhatsApp(item.phone);
                        if (!opened && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Não foi possível abrir o WhatsApp.'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.chat),
                      label: const Text('Entrar em contato',
                          style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

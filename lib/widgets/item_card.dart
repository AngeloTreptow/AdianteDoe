import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../screens/item_detail_screen.dart';
import '../services/firebase_service.dart';
import '../services/whatsapp_service.dart';
import 'report_button.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  // Injetável para permitir fakes em testes; se omitido, usa o Firebase real
  final FirebaseService? service;
  const ItemCard({super.key, required this.item, this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        // O card inteiro abre o detalhe; os botões internos continuam
        // respondendo aos próprios toques
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ItemDetailScreen(item: item, service: service),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem com cache em disco — só baixa do Storage uma vez por dispositivo
            if (item.imageUrl != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // Exibido enquanto a imagem carrega
                  placeholder: (context, url) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  // Exibido se a imagem falhar
                  errorWidget: (context, url, error) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image,
                          size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ReportButton(itemId: item.id, service: service),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final opened =
                          await WhatsAppService.openWhatsApp(item.phone);
                      if (!opened && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Não foi possível abrir o WhatsApp.'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.chat, size: 18),
                    label: const Text('Contato'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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

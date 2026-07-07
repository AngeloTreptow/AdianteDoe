import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

// Botão de denúncia (🚩) com diálogo de motivo e cooldown. Extraído do
// ItemCard para ser reutilizado na tela de detalhe do item.
class ReportButton extends StatelessWidget {
  final String itemId;
  // Injetável para permitir fakes em testes; se omitido, usa o Firebase real
  final FirebaseService? service;
  final Color color;
  const ReportButton({
    super.key,
    required this.itemId,
    this.service,
    this.color = Colors.grey,
  });

  // Intervalo mínimo entre denúncias, compartilhado por todos os botões.
  // Evita toques repetidos e denúncias duplicadas acidentais; é proteção de
  // UX, não de segurança — não impede escrita direta na API do Firestore.
  static const _reportCooldown = Duration(seconds: 30);
  static DateTime? _lastReportAt;

  @visibleForTesting
  static void resetReportCooldown() => _lastReportAt = null;

  // Abre o diálogo de denúncia e, se confirmado, grava na coleção `reports`
  Future<void> _reportItem(BuildContext context) async {
    final last = _lastReportAt;
    if (last != null) {
      final elapsed = DateTime.now().difference(last);
      if (elapsed < _reportCooldown) {
        final remaining =
            ((_reportCooldown - elapsed).inMilliseconds / 1000).ceil();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Aguarde $remaining segundos para denunciar novamente.'),
          ),
        );
        return;
      }
    }

    // Retorna o motivo digitado ao confirmar, ou null ao cancelar
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => const _ReportDialog(),
    );
    if (reason == null) return;

    try {
      await (service ?? FirebaseService())
          .reportItem(itemId, reason: reason.isNotEmpty ? reason : null);
      // Só inicia o cooldown após sucesso, para não bloquear nova tentativa
      _lastReportAt = DateTime.now();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Denúncia enviada, obrigado.')),
        );
      }
    } catch (e) {
      // Log para diagnóstico; a UI mostra só a mensagem
      debugPrint('Falha ao enviar denúncia: $e');
      // permission-denied aqui significa denúncia duplicada: as regras negam
      // create quando o documento {uid}_{itemId} já existe
      final duplicada = e is FirebaseException && e.code == 'permission-denied';
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(duplicada
                ? 'Você já denunciou este item.'
                : 'Não foi possível enviar a denúncia. Tente novamente.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _reportItem(context),
      icon: const Icon(Icons.flag_outlined, size: 20),
      tooltip: 'Denunciar',
      color: color,
    );
  }
}

// Diálogo de denúncia. É um widget com estado para que o controller do campo
// de motivo seja descartado só depois que o diálogo sair da árvore (descartar
// logo após o pop quebra durante a animação de fechamento).
class _ReportDialog extends StatefulWidget {
  const _ReportDialog();

  @override
  State<_ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<_ReportDialog> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Denunciar item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Deseja denunciar este item? Use para golpes, '
            'telefone falso ou conteúdo inadequado.',
          ),
          TextField(
            controller: _reasonController,
            maxLength: 200,
            decoration: const InputDecoration(
              labelText: 'Motivo (opcional)',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pop(context, _reasonController.text.trim()),
          child: const Text('Denunciar'),
        ),
      ],
    );
  }
}

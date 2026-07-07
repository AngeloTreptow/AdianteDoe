import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

// Envio de sugestões e comentários da comunidade. Grava na coleção
// `feedback` (write-only, uma sugestão por dispositivo por dia).
class FeedbackScreen extends StatefulWidget {
  // Injetável para permitir fakes em testes; se omitido, usa o Firebase real
  final FirebaseService? service;
  const FeedbackScreen({super.key, this.service});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late final _service = widget.service ?? FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final _messageCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      await _service.sendFeedback(_messageCtrl.text.trim());
      if (mounted) {
        // O ScaffoldMessenger raiz mantém o SnackBar visível após o pop
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sugestão enviada, obrigado! 💚')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      // Log para diagnóstico; a UI mostra só a mensagem
      debugPrint('Falha ao enviar sugestão: $e');
      // permission-denied aqui significa que o documento {uid}_{dia} já
      // existe: as regras limitam a uma sugestão por dispositivo por dia
      final jaEnviou = e is FirebaseException && e.code == 'permission-denied';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jaEnviou
                ? 'Você já enviou uma sugestão hoje. Tente novamente amanhã.'
                : 'Não foi possível enviar a sugestão. Verifique sua conexão e tente novamente.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar sugestão'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Encontrou um problema ou tem uma ideia para melhorar o '
                'AdianteDoe+? Conte pra gente — toda sugestão é lida.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _messageCtrl,
                maxLength: 1000,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Sua sugestão *',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Escreva aqui seu comentário, crítica ou ideia...',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Escreva sua sugestão'
                    : null,
              ),
              const SizedBox(height: 8),
              Text(
                'O envio é anônimo — não inclua dados pessoais como nome, '
                'telefone ou endereço.',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text('Enviar sugestão',
                        style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

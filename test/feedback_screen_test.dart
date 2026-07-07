import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adiantedoe/screens/feedback_screen.dart';
import 'package:adiantedoe/services/firebase_service.dart';

class _FakeFirebaseService extends FirebaseService {
  final sentMessages = <String>[];

  // Quando definido, sendFeedback lança em vez de gravar
  Object? error;

  @override
  Future<void> sendFeedback(String message) async {
    final e = error;
    if (e != null) throw e;
    sentMessages.add(message);
  }
}

// Abre a tela por push a partir de uma rota base, como no app real: o pop
// após o envio volta para a base, que exibe o SnackBar de confirmação
Future<void> _pumpScreen(WidgetTester tester, FirebaseService service) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FeedbackScreen(service: service),
              ),
            ),
            child: const Text('abrir'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('abrir'));
  await tester.pumpAndSettle();
}

// O texto 'Enviar sugestão' aparece na AppBar e no botão: mira no botão
final _sendButton = find.widgetWithText(ElevatedButton, 'Enviar sugestão');

Future<void> _send(WidgetTester tester, String message) async {
  await tester.enterText(find.byType(TextFormField), message);
  await tester.tap(_sendButton);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('submit vazio mostra erro de validação e não envia',
      (tester) async {
    final service = _FakeFirebaseService();
    await _pumpScreen(tester, service);

    await tester.tap(_sendButton);
    await tester.pump();

    expect(find.text('Escreva sua sugestão'), findsOneWidget);
    expect(service.sentMessages, isEmpty);
  });

  testWidgets('submit válido envia a mensagem e mostra confirmação',
      (tester) async {
    final service = _FakeFirebaseService();
    await _pumpScreen(tester, service);

    await _send(tester, 'Poderia ter busca por categoria.');

    expect(service.sentMessages, ['Poderia ter busca por categoria.']);
    expect(find.textContaining('Sugestão enviada'), findsOneWidget);
    // Após o envio a tela fecha, voltando para a rota anterior
    expect(find.byType(FeedbackScreen), findsNothing);
  });

  testWidgets('segunda sugestão no dia (permission-denied) mostra mensagem própria',
      (tester) async {
    final service = _FakeFirebaseService()
      ..error = FirebaseException(
          plugin: 'cloud_firestore', code: 'permission-denied');
    await _pumpScreen(tester, service);

    await _send(tester, 'Outra ideia.');

    expect(
      find.textContaining('já enviou uma sugestão hoje'),
      findsOneWidget,
    );
    expect(service.sentMessages, isEmpty);
  });

  testWidgets('outros erros mostram a mensagem genérica e reabilitam o botão',
      (tester) async {
    final service = _FakeFirebaseService()..error = Exception('rede');
    await _pumpScreen(tester, service);

    await _send(tester, 'Ideia qualquer.');

    expect(find.textContaining('Não foi possível enviar'), findsOneWidget);
    // O botão volta a ficar habilitado para nova tentativa
    final button = tester.widget<ElevatedButton>(_sendButton);
    expect(button.onPressed, isNotNull);
  });
}

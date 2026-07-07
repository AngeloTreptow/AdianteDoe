import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adiantedoe/models/item_model.dart';
import 'package:adiantedoe/screens/item_detail_screen.dart';
import 'package:adiantedoe/services/firebase_service.dart';
import 'package:adiantedoe/widgets/item_card.dart';
import 'package:adiantedoe/widgets/report_button.dart';

class _FakeFirebaseService extends FirebaseService {
  final reportedItemIds = <String>[];
  final reportedReasons = <String?>[];

  // Quando definido, reportItem lança em vez de gravar
  Object? error;

  @override
  Future<void> reportItem(String itemId, {String? reason}) async {
    final e = error;
    if (e != null) throw e;
    reportedItemIds.add(itemId);
    reportedReasons.add(reason);
  }
}

final _item = ItemModel(
  id: 'item1',
  name: 'Sofá 2 lugares',
  phone: '5551999998888',
  imageUrl: null,
  createdAt: DateTime(2026, 7, 5),
);

Future<void> _pumpCard(WidgetTester tester, FirebaseService service) {
  return tester.pumpWidget(
    MaterialApp(home: Scaffold(body: ItemCard(item: _item, service: service))),
  );
}

Future<void> _report(WidgetTester tester, {String? reason}) async {
  await tester.tap(find.byIcon(Icons.flag_outlined));
  await tester.pumpAndSettle();
  if (reason != null) {
    await tester.enterText(find.byType(TextField), reason);
  }
  await tester.tap(find.text('Denunciar'));
  await tester.pumpAndSettle();
}

void main() {
  setUp(ReportButton.resetReportCooldown);

  testWidgets('tocar no card abre a tela de detalhe', (tester) async {
    await _pumpCard(tester, _FakeFirebaseService());

    await tester.tap(find.text('Sofá 2 lugares'));
    await tester.pumpAndSettle();

    expect(find.byType(ItemDetailScreen), findsOneWidget);
  });

  testWidgets('denunciar com motivo grava na coleção e mostra confirmação',
      (tester) async {
    final service = _FakeFirebaseService();
    await _pumpCard(tester, service);

    await _report(tester, reason: 'Telefone falso');

    expect(service.reportedItemIds, ['item1']);
    expect(service.reportedReasons, ['Telefone falso']);
    expect(find.textContaining('Denúncia enviada'), findsOneWidget);
  });

  testWidgets('motivo vazio é enviado como nulo', (tester) async {
    final service = _FakeFirebaseService();
    await _pumpCard(tester, service);

    await _report(tester);

    expect(service.reportedItemIds, ['item1']);
    expect(service.reportedReasons, [null]);
  });

  testWidgets('cancelar não envia denúncia', (tester) async {
    final service = _FakeFirebaseService();
    await _pumpCard(tester, service);

    await tester.tap(find.byIcon(Icons.flag_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(service.reportedItemIds, isEmpty);
  });

  testWidgets('denúncia duplicada (permission-denied) mostra mensagem própria',
      (tester) async {
    final service = _FakeFirebaseService()
      ..error = FirebaseException(
          plugin: 'cloud_firestore', code: 'permission-denied');
    await _pumpCard(tester, service);

    await _report(tester);

    expect(find.text('Você já denunciou este item.'), findsOneWidget);
    expect(service.reportedItemIds, isEmpty);
  });

  testWidgets('outros erros mostram a mensagem genérica', (tester) async {
    final service = _FakeFirebaseService()..error = Exception('rede');
    await _pumpCard(tester, service);

    await _report(tester);

    expect(find.textContaining('Não foi possível enviar'), findsOneWidget);
  });

  testWidgets('segunda denúncia dentro de 30s é bloqueada pelo cooldown',
      (tester) async {
    final service = _FakeFirebaseService();
    await _pumpCard(tester, service);

    await _report(tester);
    // Aguarda o SnackBar de sucesso ser dispensado
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.flag_outlined));
    await tester.pump();

    // O diálogo não abre e nenhuma nova denúncia é gravada
    expect(find.text('Denunciar item'), findsNothing);
    expect(find.textContaining('Aguarde'), findsOneWidget);
    expect(service.reportedItemIds, hasLength(1));
  });
}

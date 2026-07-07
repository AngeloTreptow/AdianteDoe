import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adiantedoe/models/item_model.dart';
import 'package:adiantedoe/screens/item_detail_screen.dart';
import 'package:adiantedoe/services/firebase_service.dart';
import 'package:adiantedoe/widgets/report_button.dart';

class _FakeFirebaseService extends FirebaseService {
  final reportedItemIds = <String>[];

  @override
  Future<void> reportItem(String itemId, {String? reason}) async {
    reportedItemIds.add(itemId);
  }
}

ItemModel _makeItem({String? description}) => ItemModel(
      id: 'item1',
      name: 'Sofá 2 lugares',
      phone: '5551999998888',
      description: description,
      imageUrl: null,
      createdAt: DateTime(2026, 7, 5),
    );

Future<void> _pumpDetail(WidgetTester tester, ItemModel item,
    [FirebaseService? service]) {
  return tester.pumpWidget(
    MaterialApp(
      home: ItemDetailScreen(item: item, service: service),
    ),
  );
}

void main() {
  setUp(ReportButton.resetReportCooldown);

  testWidgets('mostra nome, data de publicação e descrição completa',
      (tester) async {
    await _pumpDetail(
        tester, _makeItem(description: 'Bom estado, retirar no centro.'));

    expect(find.text('Sofá 2 lugares'), findsOneWidget);
    expect(find.text('Publicado em 05/07/2026'), findsOneWidget);
    expect(find.text('Bom estado, retirar no centro.'), findsOneWidget);
  });

  testWidgets('sem descrição mostra o texto padrão', (tester) async {
    await _pumpDetail(tester, _makeItem());

    expect(find.text('O doador não adicionou uma descrição.'), findsOneWidget);
  });

  testWidgets('botão de denúncia funciona na tela de detalhe', (tester) async {
    final service = _FakeFirebaseService();
    await _pumpDetail(tester, _makeItem(), service);

    await tester.tap(find.byIcon(Icons.flag_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Denunciar'));
    await tester.pumpAndSettle();

    expect(service.reportedItemIds, ['item1']);
    expect(find.textContaining('Denúncia enviada'), findsOneWidget);
  });
}

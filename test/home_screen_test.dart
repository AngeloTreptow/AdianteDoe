import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adiantedoe/models/item_model.dart';
import 'package:adiantedoe/screens/about_screen.dart';
import 'package:adiantedoe/screens/community_rules_screen.dart';
import 'package:adiantedoe/screens/home_screen.dart';
import 'package:adiantedoe/services/firebase_service.dart';
import 'package:adiantedoe/widgets/item_card.dart';

class _FakeFirebaseService extends FirebaseService {
  final List<ItemModel> items;
  _FakeFirebaseService(this.items);

  @override
  Stream<List<ItemModel>> getItems() => Stream.value(items);
}

List<ItemModel> _makeItems(int count) => List.generate(
      count,
      (i) => ItemModel(
        id: 'item$i',
        name: 'Item $i',
        phone: '5551999998888',
        imageUrl: null,
        createdAt: DateTime(2026, 7, 6),
      ),
    );

void main() {
  setUp(ItemCard.resetReportCooldown);

  testWidgets('lista renderiza os itens do stream', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: HomeScreen(service: _FakeFirebaseService(_makeItems(3)))),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ItemCard), findsNWidgets(3));
    expect(find.text('Item 0'), findsOneWidget);
  });

  testWidgets('lista tem respiro inferior para o FAB não cobrir o último card',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: HomeScreen(service: _FakeFirebaseService(_makeItems(3)))),
    );
    await tester.pumpAndSettle();

    final list = tester.widget<ListView>(find.byType(ListView));
    final padding = list.padding!.resolve(TextDirection.ltr);
    // FAB estendido (~56px) + margem (16px): o fim da lista precisa rolar
    // para cima dele, senão o botão de contato do último item fica inacessível
    expect(padding.bottom, greaterThanOrEqualTo(72));
  });

  testWidgets('stream vazio mostra o convite para doar', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: HomeScreen(service: _FakeFirebaseService(const []))),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Seja o primeiro a doar'), findsOneWidget);
  });

  testWidgets('menu da AppBar abre a tela Sobre o app', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: HomeScreen(service: _FakeFirebaseService(const []))),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sobre o app'));
    await tester.pumpAndSettle();

    expect(find.byType(AboutScreen), findsOneWidget);
  });

  testWidgets('menu da AppBar abre a tela Regras da comunidade',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: HomeScreen(service: _FakeFirebaseService(const []))),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Regras da comunidade'));
    await tester.pumpAndSettle();

    expect(find.byType(CommunityRulesScreen), findsOneWidget);
  });
}

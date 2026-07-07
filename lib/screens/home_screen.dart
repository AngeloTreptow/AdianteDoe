import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../widgets/item_card.dart';
import 'add_item_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdianteDoe+'),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
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
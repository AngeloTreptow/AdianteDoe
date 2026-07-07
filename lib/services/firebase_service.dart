import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/feedback_model.dart';
import '../models/item_model.dart';
import '../models/report_model.dart';

class FirebaseService {
  // Getter lazy: permite criar fakes desta classe em testes sem inicializar o Firebase
  CollectionReference<Map<String, dynamic>> get _col =>
      FirebaseFirestore.instance.collection('items');

  CollectionReference<Map<String, dynamic>> get _reportsCol =>
      FirebaseFirestore.instance.collection('reports');

  CollectionReference<Map<String, dynamic>> get _feedbackCol =>
      FirebaseFirestore.instance.collection('feedback');

  Future<void> addItem(ItemModel item) async {
    await _col.add(item.toMap());
  }

  Stream<List<ItemModel>> getItems() {
    final cutoff = DateTime.now().subtract(const Duration(days: 14));
    return _col
        .where('createdAt', isGreaterThan: Timestamp.fromDate(cutoff))
        .orderBy('createdAt', descending: true)
        .limit(25) // Limita a 25 itens para economizar leituras
        .snapshots()
        .map((snap) => snap.docs.map(ItemModel.fromDoc).toList());
  }

  // Grava a denúncia na coleção `reports` sem alterar o documento do item.
  // O ID do documento é determinístico ({uid}_{itemId}) para que as regras do
  // Firestore bloqueiem denúncia duplicada do mesmo item pelo mesmo
  // dispositivo. As regras permitem apenas create (nunca read/update/delete),
  // para que denúncias não possam ser lidas ou apagadas por clientes.
  Future<void> reportItem(String itemId, {String? reason}) async {
    // Recupera a sessão anônima caso o login do bootstrap tenha falhado
    // (ex.: primeira abertura sem rede); se falhar de novo, a exceção
    // propaga e o card mostra a mensagem de erro
    final user = FirebaseAuth.instance.currentUser ??
        (await FirebaseAuth.instance.signInAnonymously()).user;
    if (user == null) {
      throw StateError('Sem sessão anônima para registrar a denúncia');
    }
    await _reportsCol.doc('${user.uid}_$itemId').set(
          ReportModel(
            id: '',
            itemId: itemId,
            reason: reason,
            createdAt: DateTime.now(),
          ).toMap(),
        );
  }

  // Grava a sugestão na coleção `feedback`, seguindo o mesmo padrão de
  // `reports`: create-only e ID determinístico. Aqui o ID é {uid}_{dia},
  // então as regras do Firestore limitam a uma sugestão por dispositivo
  // por dia (a segunda tentativa falha com permission-denied).
  Future<void> sendFeedback(String message) async {
    // Recupera a sessão anônima caso o login do bootstrap tenha falhado,
    // como em reportItem
    final user = FirebaseAuth.instance.currentUser ??
        (await FirebaseAuth.instance.signInAnonymously()).user;
    if (user == null) {
      throw StateError('Sem sessão anônima para enviar a sugestão');
    }
    final now = DateTime.now();
    final day = '${now.year.toString().padLeft(4, '0')}'
        '-${now.month.toString().padLeft(2, '0')}'
        '-${now.day.toString().padLeft(2, '0')}';
    await _feedbackCol.doc('${user.uid}_$day').set(
          FeedbackModel(
            id: '',
            message: message,
            day: day,
            createdAt: now,
          ).toMap(),
        );
  }
}

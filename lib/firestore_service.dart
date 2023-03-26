import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezstock/frozen_item.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'frozen_items';

  // 冷凍庫の中身を取得するメソッド
  Stream<List<FrozenItem>> getFrozenItems() {
    return _firestore.collection(_collectionName).snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => FrozenItem.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  // 冷凍庫に新しい食品を追加するメソッド
  Future<void> addFrozenItem(FrozenItem item) {
    return _firestore.collection(_collectionName).add(item.toJson());
  }

  // 選択した食品の情報を更新するメソッド
  Future<void> updateFrozenItem(FrozenItem item) {
    return _firestore
        .collection(_collectionName)
        .doc(item.id)
        .update(item.toJson());
  }

  // 選択した食品を削除するメソッド
  Future<void> deleteFrozenItem(String itemId) {
    return _firestore.collection(_collectionName).doc(itemId).delete();
  }
}

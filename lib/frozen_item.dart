class FrozenItem {
  final String? id;
  final String name;
  final int quantity;
  final DateTime expirationDate;
  final DateTime addedDate;

  FrozenItem({
    this.id,
    required this.name,
    required this.quantity,
    required this.expirationDate,
    required this.addedDate,
  });

  // JSONデータをFrozenItemオブジェクトに変換するファクトリメソッド
  factory FrozenItem.fromJson(Map<String, dynamic> json) {
    return FrozenItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      expirationDate:
          DateTime.fromMillisecondsSinceEpoch(json['expirationDate']),
      addedDate: DateTime.fromMillisecondsSinceEpoch(json['addedDate']),
    );
  }

  // FrozenItemオブジェクトをJSONデータに変換するメソッド
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'expirationDate': expirationDate.millisecondsSinceEpoch,
      'addedDate': addedDate.millisecondsSinceEpoch,
    };
  }
}

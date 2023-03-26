import 'package:flutter/material.dart';
import 'package:freezstock/frozen_item.dart';
import 'package:freezstock/firestore_service.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _firestoreService = FirestoreService();

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _expirationDateController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final item = FrozenItem(
      name: _nameController.text,
      quantity: int.parse(_quantityController.text),
      expirationDate: DateTime.parse(_expirationDateController.text),
      addedDate: DateTime.now(),
    );

    await _firestoreService.addFrozenItem(item);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アイテム追加'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'アイテム名'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'アイテム名を入力してください';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: '数量'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '数量を入力してください';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _expirationDateController,
              decoration: InputDecoration(labelText: '期限 (yyyy-MM-dd)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '期限を入力してください';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}

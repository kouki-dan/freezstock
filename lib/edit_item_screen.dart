import 'package:flutter/material.dart';
import 'package:freezstock/frozen_item.dart';
import 'package:freezstock/firestore_service.dart';

class EditItemScreen extends StatefulWidget {
  final FrozenItem item;

  EditItemScreen({required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _expirationDateController;

  final _formKey = GlobalKey<FormState>();
  final _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    _expirationDateController = TextEditingController(
        text: widget.item.expirationDate.toLocal().toString().split(' ')[0]);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _expirationDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アイテムを編集'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _firestoreService.updateFrozenItem(
                  FrozenItem(
                    id: widget.item.id,
                    name: _nameController.text,
                    quantity: int.parse(_quantityController.text),
                    expirationDate:
                        DateTime.parse(_expirationDateController.text),
                    addedDate: widget.item.addedDate,
                  ),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
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
                decoration: InputDecoration(labelText: '期限'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '期限を入力してください';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:freezstock/frozen_item.dart';
import 'package:freezstock/edit_item_screen.dart';

class ItemDetailsScreen extends StatelessWidget {
  final FrozenItem item;

  ItemDetailsScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditItemScreen(item: item),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'アイテム名: ${item.name}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              '数量: ${item.quantity}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              '期限: ${item.expirationDate.toLocal().toString().split(' ')[0]}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

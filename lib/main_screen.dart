import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezstock/firestore_service.dart';
import 'package:freezstock/frozen_item.dart';
import 'package:freezstock/add_item_screen.dart';
import 'package:freezstock/item_details_screen.dart';
import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('冷凍庫の中身'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<FrozenItem>>(
        stream: _firestoreService.getFrozenItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data;
          if (items == null || items.isEmpty) {
            return Center(child: Text('冷凍庫にアイテムがありません'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailsScreen(item: item),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                      '期限: ${item.expirationDate.toLocal().toString().split(' ')[0]}'),
                  trailing: Text('数量: ${item.quantity}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          ).then((_) {
            setState(() {}); // アイテム追加後にリストを更新する
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

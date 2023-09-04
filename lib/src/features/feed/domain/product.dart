
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final int stock;
  final int price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.price
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      stock: json['stock'] as int,
      price: json['price'] as int,
    );
  }

  factory Product.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Product(
      id: snapshot.id,
      name: data?['name'],
      description: data?['description'],
      stock: data?['stock'],
      price: data?['price']
    );
  }
}
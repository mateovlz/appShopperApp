import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopper_mv_app/src/features/feed/domain/product.dart';

// A function that converts a response body into a List<Photo>.

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);


  void fetchProducts() async {

    final db = FirebaseFirestore.instance;
    final List<Product> lstProducts = await db.collection("products").get().then(
            (querySnapshot) => querySnapshot.docs.map((e) => Product.fromFirestore(e, null)).toList()
    );
    state =  lstProducts;
  }

}


List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

void deleteProduct(String id){
  var db = FirebaseFirestore.instance;
  final deleted = db.collection("products").doc(id).delete().then(
        (doc) => print("Document deleted"),
    onError: (e) => print("Error updating document $e"),
  );
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_estudo/datas/product_data.dart';

class CartProduct {
  String cid;
  String category;
  String pid;

  int quantity;
  String size;

  ProductData productData;

  CartProduct.fromDocument(DocumentSnapshot document) {
    this.cid = document.documentID;
    this.category = document.data["category"];
    this.pid = document.data["pid"];
    this.quantity = document.data["quantity"];
    this.size = document.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": this.category,
      "pid": this.pid,
      "quantity": this.quantity,
      "size": this.size,
      "product": productData.toResumedMap()
    };
  }
}

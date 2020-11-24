import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_estudo/constants.dart';
import 'package:e_commerce_estudo/tiles/category_tile.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        else {
          var dividedTiles = ListTile.divideTiles(
                  tiles: snapshot.data.documents.map((document) {
                    return CategoryTile(document);
                  }).toList(),
                  color: Colors.grey[300])
              .toList();

          return ListView(children: dividedTiles);
        }
      },
    );
  }
}

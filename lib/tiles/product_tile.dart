import 'package:e_commerce_estudo/constants.dart';
import 'package:e_commerce_estudo/datas/product_data.dart';
import 'package:e_commerce_estudo/screens/products/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  ProductTile(this.type, this.product);

  final String type;
  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product)));
      },
      child: Card(
        child: type == "grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text("R\$${product.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ))
                ],
              )
            : Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(product.images[0],
                        fit: BoxFit.cover, height: 250),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text("R\$${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

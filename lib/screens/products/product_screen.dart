import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_commerce_estudo/constants.dart';
import 'package:e_commerce_estudo/datas/product_data.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen(this.product);

  final ProductData product;
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
              aspectRatio: 0.9,
              child: Carousel(
                dotSize: 4,
                dotBgColor: Colors.transparent,
                dotSpacing: 15,
                dotColor: kPrimaryColor,
                dotIncreasedColor: kPrimaryColor,
                autoplay: false,
                images: widget.product.images.map((url) {
                  return NetworkImage(url);
                }).toList(),
              )),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${widget.product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                const Text("Tamanho",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.5),
                    children: widget.product.sizes.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectSize = size;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                  width: 2,
                                  color: size == selectSize
                                      ? kPrimaryColor
                                      : Colors.grey[500])),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(size),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: selectSize != null ? () {} : null,
                    child: const Text(
                      "Adicionar ao Carrinho",
                      style: TextStyle(fontSize: 18),
                    ),
                    color: kPrimaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                const Text("Descrição",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(
                  widget.product.description,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

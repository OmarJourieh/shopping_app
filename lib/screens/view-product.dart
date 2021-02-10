import 'package:e_commerce/components/cart_button.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProduct extends StatefulWidget {
  Product product;

  ViewProduct({this.product});

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  Color _shadowColor = Colors.purple.withOpacity(0.8);

  Color _secondaryShadowColor = Colors.purple[100];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _shadowColor,
        title: Text(widget.product.name),
        actions: [
          //CartButton(),
        ],
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: [
              _mainImage(height, width),
              Stack(
                children: [
                  Container(
                    height: height * 0.5,
                    width: width,
                    // color: Colors.red,
                  ),
                  Positioned(
                    top: 30,
                    left: 30,
                    height: height * 0.5,
                    width: width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _productDescription(width),
                        SizedBox(height: 40),
                        _priceCard(width, () {
                          print("Adding product " +
                              widget.product.name +
                              " to cart");
                          cartProvider.addToCart(widget.product);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Product added successfully!",
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: _shadowColor,
                            ),
                          );
                          setState(() {});
                        }, cartProvider, context),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customline(width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      height: 1.0,
      color: Colors.black,
      width: width,
    );
  }

  Widget _productDescription(width) {
    return Container(
      // margin: EdgeInsets.only(right: 30),
      width: width * 0.9,
      child: Text(widget.product.description, style: TextStyle(fontSize: 17.0)),
    );
  }

  Widget _priceCard(width, callback, cartProvider, context) {
    return Column(
      children: [
        _customline(width),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("\$" + widget.product.price.toString()),
            Container(
              // alignment: Alignment.center,
              // width: width * 0.8,
              child: !cartProvider.hasProduct(widget.product)
                  ? OutlineButton(
                      borderSide: BorderSide(width: 1.0, color: _shadowColor),
                      highlightColor: _shadowColor,
                      onPressed: callback,
                      child: Text("Add to Cart"),
                      highlightedBorderColor: Colors.transparent,
                    )
                  : OutlineButton(
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Product already added to cart!",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: _shadowColor,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.check,
                        color: Colors.lightGreen,
                      ),
                    ),
            ),
          ],
        ),
        _customline(width),
      ],
    );
  }

  Widget _mainImage(height, width) {
    return Container(
      height: height * 0.5,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.product.picture),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

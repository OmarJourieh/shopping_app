import 'package:e_commerce/screens/view_cart.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ViewCart()));
        },
        icon: Icon(Icons.shopping_cart),
      ),
    );
  }
}

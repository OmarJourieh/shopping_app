import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/view-product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCart extends StatefulWidget {
  @override
  _ViewCartState createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  Color _shadowColor = Colors.purple.withOpacity(0.8);
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    List<Product> products = cartProvider.cart.products;
    double total_price = cartProvider.total_price;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _shadowColor,
        title: Text("Total: \$" + total_price.toStringAsFixed(2)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product p = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ViewProduct(product: p),
                  ),
                );
              },
              child: ListTile(
                title: Text(p.name),
                subtitle: Text("\$" + p.price.toString()),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    cartProvider.removeFromCart(p);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

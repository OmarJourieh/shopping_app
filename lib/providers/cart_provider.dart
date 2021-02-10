import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  Cart cart = Cart();
  double total_price = 0;

  CartProvider() {
    this.cart.products = List<Product>();
  }

  Future<Cart> getCart() async {
    return await this.cart;
  }

  // void createCart(Cart cart) {
  //   this.cart = cart;
  // }

  void addToCart(Product product) {
    if (this.cart.products == null) {
      this.cart.products = List<Product>();
    }
    this.cart.products.add(product);
    this.total_price += product.price;
    notifyListeners();
  }

  void removeFromCart(Product product) {
    this.cart.products.removeWhere((element) => element.id == product.id);
    this.total_price -= product.price;
    notifyListeners();
  }

  bool hasProduct(Product product) {
    for (var prod in cart.products) {
      if (prod.id == product.id) {
        return true;
      }
    }
    return false;
  }
}

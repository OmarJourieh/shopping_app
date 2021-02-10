import 'package:dio/dio.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> products = [
    Product(
      id: 1,
      marketId: 1,
      categoryId: 1,
      name: "product 1",
      description: "description of product 1description of product description of product description of product description of product description of product description of product description of product description of product description of product description of product description of product description of product description of ",
      price: 99.99,
      isOffer: 0,
      picture: "assets/images/cart01.jpg",
    ),
    Product(
      id: 2,
      marketId: 1,
      categoryId: 2,
      name: "product 2",
      description: "description of product 1",
      price: 99.99,
      isOffer: 0,
      picture: "assets/images/cart01.jpg",
    ),
    Product(
      id: 3,
      marketId: 1,
      categoryId: 3,
      name: "product 3",
      description: "description of product 1",
      price: 99.99,
      isOffer: 0,
      picture: "assets/images/cart01.jpg",
    ),
    Product(
      id: 4,
      marketId: 1,
      categoryId: 2,
      name: "Lenovo Y520",
      description: "Very powerful gaming PC",
      price: 1200,
      isOffer: 0,
      picture: "assets/images/shop01.jpg",
    ),
  ];

  Future<List<Product>> getAllProducts() async {
    return await this.products;
  }

  Future<List<Product>> getProductsByCategory(int id) async {
    return await this.products.where((element) => element.categoryId == id).toList();
  }


}

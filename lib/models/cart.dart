// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

import 'package:e_commerce/models/product.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
    Cart({
        this.id,
        this.userId,
        this.marketId,
        this.products,
    });

    int id;
    int userId;
    int marketId;
    List<Product> products;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["user_id"],
        marketId: json["market_id"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "market_id": marketId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}
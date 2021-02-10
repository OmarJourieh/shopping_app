// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    Product({
        this.id,
        this.marketId,
        this.categoryId,
        this.name,
        this.description,
        this.price,
        this.isOffer,
        this.picture,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int marketId;
    int categoryId;
    String name;
    String description;
    double price;
    int isOffer;
    String picture;
    dynamic createdAt;
    dynamic updatedAt;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        marketId: json["market_id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        isOffer: json["is_offer"],
        picture: json["picture"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "market_id": marketId,
        "category_id": categoryId,
        "name": name,
        "description": description,
        "price": price,
        "is_offer": isOffer,
        "picture": picture,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

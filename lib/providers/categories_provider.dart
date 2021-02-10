import 'package:dio/dio.dart';
import 'package:e_commerce/models/category.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Category> categories = [
    Category(id: 1, name: "Phones", image: "assets/images/phones.jpg"),
    Category(id: 2, name: "Computers", image: "assets/images/computers.jpg"),
    Category(id: 3, name: "Hard Drives", image: "assets/images/harddrives.jpg"),
    Category(id: 4, name: "Graphics Cards", image: "assets/images/gpus.jpg"),
  ];

  Future<List<Category>> getAllCategories() async {
    return await this.categories;
  }


}

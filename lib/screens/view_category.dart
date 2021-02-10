import 'package:e_commerce/components/cart_button.dart';
import 'package:e_commerce/components/product-card.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/categories_provider.dart';
import 'package:e_commerce/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCategory extends StatefulWidget {
  Category category;
  ViewCategory({this.category});

  @override
  _ViewCategoryState createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Color _shadowColor = Colors.purple.withOpacity(0.8);

  @override
  Widget build(BuildContext context) {
    // final categoriesProvider = Provider.of<CategoriesProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: _shadowColor,
        actions: [
          CartButton(),
        ],
      ),
      body: Container(
        child:
            _productsTab(height, width, productsProvider, widget.category.id),
      ),
    );
  }

  Widget _productsTab(height, width, productsProvider, id) {
    return FutureBuilder(
        future: productsProvider.getProductsByCategory(id),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          List<Product> products = snapshot.data;
          print(products);
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              return productsProvider.getAllProducts().then((_) {
                setState(() {});
              });
            },
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                    height: height, width: width, product: products[index]);
              },
            ),
          );
        });
  }
}

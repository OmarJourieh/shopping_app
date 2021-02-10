import 'package:dio/dio.dart';
import 'package:e_commerce/components/cart_button.dart';
import 'package:e_commerce/components/product-card.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/categories_provider.dart';
import 'package:e_commerce/providers/products_provider.dart';
import 'package:e_commerce/screens/view_cart.dart';
import 'package:e_commerce/screens/view_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color _shadowColor = Colors.purple.withOpacity(0.8);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _shadowColor,
          actions: [
            CartButton(),
          ],
          title: Text("E-Commerce"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.store)),
              Tab(icon: Icon(Icons.category)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _productsTab(height, width, productsProvider),
            _categoriesTab(height, width, categoriesProvider),
          ],
        ),
      ),
    );
  }

  Widget _categoriesTab(height, width, categoriesProvider) {
    return FutureBuilder(
      future: categoriesProvider.getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        List<Category> categories = snapshot.data;
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ViewCategory(
                        category: categories[index],
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 2.0),
                      height: height * 0.4,
                      width: width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(categories[index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 2.0),
                      height: height * 0.4,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.bottomCenter,
                          end: FractionalOffset.topCenter,
                          colors: [
                            Colors.transparent,
                            _shadowColor,
                            Colors.transparent
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        categories[index].name,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      top: height * 0.2,
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  Widget _backgroundEffect() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
          colors: [Colors.blue[900].withOpacity(0.5), Colors.transparent],
        ),
      ),
    );
  }

  Widget _productsTab(height, width, productsProvider) {
    return FutureBuilder(
        future: productsProvider.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          List<Product> products = snapshot.data;
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

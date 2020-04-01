import 'package:ecommerce/MainWidgets/products.dart';
import 'package:flutter/material.dart';

import './MainWidgets/carousel_images.dart';
import './MainWidgets/navigation_drawer.dart';
import './MainWidgets/horizontal_list_view.dart';

void main() => runApp(EcommerceApp());

class EcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text('E-Commerce app'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){},),
          IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white,), onPressed: (){},)
        ],
      ),

      drawer: NavigationDrawer(),
      body: ListView(
        children: <Widget>[
          CarouselImages(), //main image slider
          HorizontalListView(), //categories horizontal list
          Products(), //list of products items
        ],
      ),
    );
  }
}

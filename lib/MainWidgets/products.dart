import 'package:ecommerce/models/products_model.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  
  final product_list = [
    ProductsModel(name: 'Blazer', picture: 'images/products/blazer1', oldPrice: 120, price: 85,),
    ProductsModel(name: 'Red dress', picture: 'images/products/dress1', oldPrice: 120, price: 85,),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 8,),
          child: Text('Recent Products', style: TextStyle(fontSize: 18),),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
        ),
      ],
    );
  }
}
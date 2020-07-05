import 'package:flutter/material.dart';

import '../MainWidgets/custom_app_bar.dart';
import './shopping_cart_details.dart';
import '../providers/cart_model.dart';

class ShoppingCartScreen extends StatefulWidget {

  final cartList = [
    CartModel(name: 'blazer1', picture: 'images/products/blazer1.jpeg', oldPrice: 125, price: 85, color: 'red', quantity: 1, size: 'm',),
    CartModel(name: 'blazer2', picture: 'images/products/blazer2.jpeg', oldPrice: 125, price: 85, color: 'blue', quantity: 1, size: 'm',),
    CartModel(name: 'dress1', picture: 'images/products/dress1.jpeg', oldPrice: 125, price: 85, color: 'brown', quantity: 1, size: 'm',),
    CartModel(name: 'dress2', picture: 'images/products/dress2.jpeg', oldPrice: 125, price: 85, color: 'black', quantity: 1, size: 'm',),
    CartModel(name: 'hills1', picture: 'images/products/hills1.jpeg', oldPrice: 125, price: 85, color: 'black', quantity: 1, size: 'm',),
    CartModel(name: 'hills2', picture: 'images/products/hills2.jpeg', oldPrice: 125, price: 85, color: 'yellow', quantity: 1, size: 'm',),
    CartModel(name: 'pants1', picture: 'images/products/pants1.jpg', oldPrice: 125, price: 85, color: 'green', quantity: 1, size: 'm',),
    CartModel(name: 'pants2', picture: 'images/products/pants2.jpeg', oldPrice: 125, price: 85, color: 'grey', quantity: 1, size: 'm',),
    CartModel(name: 'shoe', picture: 'images/products/shoe1.jpg', oldPrice: 125, price: 85, color: 'black', quantity: 1, size: 'm',),
    CartModel(name: 'skt1', picture: 'images/products/skt1.jpeg', oldPrice: 125, price: 85, color: 'blueAccent', quantity: 1, size: 'm',),
    CartModel(name: 'skt2', picture: 'images/products/skt2.jpeg', oldPrice: 125, price: 85, color: 'redAccent', quantity: 1, size: 'm',),
  ];

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Shopping cart',
        iconButton: false,
      ),

      //list of reservaton products
      body: ShoppingCartDetails(cartList: widget.cartList,),

      //check out button and the total count of reservation products
      bottomNavigationBar: Container(
        color: Colors.red,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(4),
                child: ListTile(
                  title: Text('\$ 230',style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.w600),),
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: (){},
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 16,),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
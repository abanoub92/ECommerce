import '../providers/cart_model.dart';
import 'package:flutter/material.dart';

class ShoppingCartDetails extends StatefulWidget {
  
  final List<CartModel> cartList;

  ShoppingCartDetails({this.cartList});
  
  @override
  _ShoppingCartDetailsState createState() => _ShoppingCartDetailsState();
}

class _ShoppingCartDetailsState extends State<ShoppingCartDetails> {
  
  int _shoppingCartCount = 0;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cartList.length,
      itemBuilder: (context, index){
        return Card(
          child: ListTile(
            leading: Image.asset(widget.cartList.elementAt(index).getPicture),
            title: Text(widget.cartList.elementAt(index).getName),
            subtitle: Column(
              children: <Widget>[
                //Size & color row
                Padding(
                  padding: EdgeInsets.only(top:4),
                  child: Row(
                    children: <Widget>[
                      //Size data item
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text('Size: '),
                            Text(widget.cartList.elementAt(index).getSize),
                          ],
                        ),
                      ),

                      //Color data item
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text('Color: '),
                            Text(widget.cartList.elementAt(index).getColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Quantity data item
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.arrow_left), 
                          onPressed: (){
                            decreaseCount(widget.cartList.elementAt(index).getQuantity);
                          }
                        ), 
                      ),

                      Expanded(
                        child: Center(
                          child: Text('$_shoppingCartCount',),
                        ),
                      ),

                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.arrow_right), 
                          onPressed: (){
                            increaseCount(widget.cartList.elementAt(index).getQuantity);
                          }
                        ), 
                      )
                    ],
                  ),
                )
              ],
            ),

            //price data item
            trailing: Text('\$ ${widget.cartList.elementAt(index).getPrice}'),
           ),
        );
      },
    );
  }

  void increaseCount(int quantity){ 
    setState(() {
      _shoppingCartCount = quantity++; 
    });
  }
  void decreaseCount(int quantity){ 
    setState(() {
      _shoppingCartCount = quantity--; 
    });
  }

}
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {

  final String title;
  final bool iconButton;

  @override
  final Size preferredSize;

  CustomAppBar({Key key, this.title, this.iconButton}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key : key);
  
  @override
  _CustomAppBarState createState() {
    return _CustomAppBarState();
  }

}

class _CustomAppBarState extends State<CustomAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text(widget.title, style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Theme.of(context).accentColor,),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Theme.of(context).accentColor,), onPressed: (){},),
          IconButton(icon: Icon(Icons.notifications, color: Theme.of(context).accentColor,), onPressed: (){})
          // Visibility(
          //   visible: widget.iconButton,
          //   child: IconButton(
          //     icon: Icon(Icons.shopping_cart, color: Colors.black,), 
          //     onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_){ return ShoppingCart(); })); },
          //   ),
          // ),
        ],
      );
  }
}
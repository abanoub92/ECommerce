import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person, color: Colors.white,),
              ),
            ),
            decoration: BoxDecoration(color: Colors.red),
            accountName: Text("Abanoub ghabreal"),
            accountEmail: Text("abanoub.eskander15@gmail.com"),
          ),
          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text("Home page"),
              leading: Icon(Icons.home, color: Colors.red,),
            ),
          ),

          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text("My Account"),
              leading: Icon(Icons.person, color: Colors.red,),
            ),
          ),

          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text("My Orders"),
              leading: Icon(Icons.shopping_basket, color: Colors.red,),
            ),
          ),

          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text("Categories"),
              leading: Icon(Icons.category, color: Colors.red,),
            ),
          ),

          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text("Favourites"),
              leading: Icon(Icons.favorite, color: Colors.red,),
            ),
          ),

          Divider(height: 4, color: Colors.red, indent: 16, endIndent: 16,),

          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings, color: Colors.red,),
            ),
          ),

          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text("About"),
              leading: Icon(Icons.help, color: Colors.red,),
            ),
          )
        ],
      ),
    );
  }
}

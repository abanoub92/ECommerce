import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/welcome_screen.dart';
import '../utils/shared_preference_service.dart';

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
            decoration: BoxDecoration(color: Colors.white),
            accountName: Text('Abanoub ghabreal', style: TextStyle(color: Colors.black),),
            accountEmail: Text('abanoub.eskander15@gmail.com', style: TextStyle(color: Colors.black),),
          ),

          ListTile(
              title: Text("Home page"),
              leading: Icon(Icons.home, color: Theme.of(context).accentColor,),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_){ return HomeScreen(); })
                );
              },
          ),

          ListTile(
              title: Text("My Account"),
              leading: Icon(Icons.person, color: Theme.of(context).accentColor,),
              onTap: (){},
          ),

          ListTile(
              title: Text("My Orders"),
              leading: Icon(Icons.shopping_basket, color: Theme.of(context).accentColor,),
              onTap: (){},
          ),

          ListTile(
              title: Text("Categories"),
              leading: Icon(Icons.category, color: Theme.of(context).accentColor,),
              onTap: (){},
          ),

          ListTile(
              title: Text("Favorites"),
              leading: Icon(Icons.favorite, color: Theme.of(context).accentColor,),
              onTap: (){},
          ),

          Divider(height: 4, color: Colors.red, indent: 16, endIndent: 16,),

          ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings, color: Theme.of(context).accentColor,),
              onTap: (){},
          ),

          ListTile(
              title: Text("About"),
              leading: Icon(Icons.help, color: Theme.of(context).accentColor,),
              onTap: (){},
          ),

          ListTile(
            title: Text("Sign Out"),
            leading: Icon(Icons.exit_to_app, color: Theme.of(context).accentColor,),
            onTap: () async {
              final service = await SharedPreferenceService.instance;
              service.setLoginCode(false);
              Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

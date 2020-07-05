import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MainWidgets/carousel_images.dart';
import '../MainWidgets/custom_app_bar.dart';
import '../MainWidgets/navigation_drawer.dart';
import '../MainWidgets/category_item.dart';
import '../MainWidgets/special_product_item.dart';
import '../screens/products_screen.dart';

class HomeScreen extends StatelessWidget {
  
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
        iconButton: true,
      ),
      drawer: NavigationDrawer(),
      body: Container(
        //Make it easy for us to display all data from child list/grid view
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //categories list
              CategoryItem(),

              //offers and ads slider
              CarouselImages(),

              //daily deals
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Daily Deals', style: TextStyle(fontSize: 18),),
                          RaisedButton(
                            child: Text('View All', style: TextStyle(color: Colors.white),),
                            color: Theme.of(context).accentColor, 
                            onPressed: () => Navigator.of(context).pushNamed(
                              ProductsScreen.routeName,
                              arguments: {
                                'categoryId': 0,
                                'title': 'Daily Deals'
                              }
                            ))
                        ],
                      ),
                    ),
                    SpecialProductItem('isDailyDeal'),
                  ],
                ),
              ),

              //trending products
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('#Trending', style: TextStyle(fontSize: 18),),
                          RaisedButton(
                            child: Text('View All', style: TextStyle(color: Colors.white),),
                            color: Theme.of(context).accentColor, 
                            onPressed: () => Navigator.of(context).pushNamed(
                              ProductsScreen.routeName,
                              arguments: {
                                'categoryId': 0,
                                'title': '#Trending'
                              }
                            )),
                        ],
                      ),
                    ),
                    SpecialProductItem('isTrending'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../MainWidgets/custom_app_bar.dart';
import '../providers/product_detail_provider.dart';

class ProductDetailScreen extends StatelessWidget {

  static const routeName = '/product-detail';

  ProductDetailScreen();
  
  @override
  Widget build(BuildContext context) {

    final routeData = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final title = routeData['title'];
    final productId = routeData['productId'];

    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        iconButton: true,
      ),
      body: FutureBuilder(
        future: Provider.of<ProductDetailProvider>(context, listen: false).fetchProductDetail(productId),
        builder: (ctx, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          else {
            if (snapshot.error != null) return Center(child: Text(snapshot.error.toString()));
            else {
              return Consumer<ProductDetailProvider>(
                builder: (ct, detail, _) => SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //product images slider 
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: Stack(
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.favorite_border, color: Colors.white,), onPressed: (){}),
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: false,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                autoPlayAnimationDuration: Duration(milliseconds: 1000,),
                                enlargeCenterPage: true,
                              ),
                              items: detail.item.images.map((image) => Image.network(image)).toList(), 
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }  
        }
      ),
    );
  }
}
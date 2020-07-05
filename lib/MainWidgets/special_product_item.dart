import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class SpecialProductItem extends StatelessWidget {

  final String fetchType;

  SpecialProductItem(this.fetchType);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ProductProvider>(context, listen: false).fetchSpicalProducts(fetchType),
      builder: (ctx, snapShot){
        if (snapShot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator(),);
        else {
          if (snapShot.error != null) return Text(snapShot.error.toString());
          else {
            return Consumer<ProductProvider>(
              builder: (ctx, product, _) => Container(
                width: double.infinity,
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fetchType == 'isDailyDeal' ? product.dailyDealsItems.length : product.trendingsItems.length,
                  itemBuilder: (ctx, index){
                    return Container(
                      width: 120,
                      height: 120,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            fetchType == 'isDailyDeal' 
                            ? product.dailyDealsItems[index].imageUrl 
                            : product.trendingsItems[index].imageUrl,
                            width: 100,
                            height: 120,
                          ),
                          Text(
                            fetchType == 'isDailyDeal' 
                            ? product.dailyDealsItems[index].title 
                            : product.trendingsItems[index].title,
                            style: TextStyle(fontSize: 16, ),
                            maxLines: 1,
                          ),
                          Text(
                            fetchType == 'isDailyDeal' 
                            ? product.dailyDealsItems[index].price 
                            : product.trendingsItems[index].price,
                            style: TextStyle(fontSize: 16, ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ); 
                  },
                ),
              ),
            );
          }
        }  
      },
    );
  }
}

// ListTile(
//   leading: Image.network(
//     category.items[index].image, 
//     fit: BoxFit.contain,
//     color: Colors.white,
//     height: 30,
//     width: 30,
//     alignment: Alignment.centerLeft,
//   ),
//   title: Text(
//     category.items[index].title,
//     style: TextStyle(color: Colors.white, fontSize: 16),
//     textAlign: TextAlign.left,
//   ),
// ),

// Container(
//                       width: 150,
//                       height: 60,
//                       padding: const EdgeInsets.all(8),
//                       color: Colors.blue,
//                       child: Row(
//                         children: <Widget>[
//                           Image.network(category.items[index].image, color: Colors.white, fit: BoxFit.contain,),
//                           Text(category.items[index].title, style: TextStyle(color: Colors.white),),
//                         ],
//                       ),
//                     );
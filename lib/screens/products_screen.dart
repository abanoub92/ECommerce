import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MainWidgets/custom_app_bar.dart';
import '../providers/product_provider.dart';
import './product_detail_screen.dart';

class ProductsScreen extends StatelessWidget {

  static const routeName = '/product';

  @override
  Widget build(BuildContext context) {

    final routeData = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final title = routeData['title'];
    final categoryId = routeData['categoryId'];

    
    // find the selected displayed list  
    Future<void> findSelectedList(context){
      if (categoryId != 0)
        return Provider.of<ProductProvider>(context, listen: false).fetchProducts(categoryId);
      else if (title == 'Daily Deals')
        return Provider.of<ProductProvider>(context, listen: false).fetchSpicalProducts('isDailyDeal');
      else 
        return Provider.of<ProductProvider>(context, listen: false).fetchSpicalProducts('isTrending');  
    }

    // get the length of selected list
    int getListSize(product){
      if (categoryId != 0)
        return product.items.length; 
      else if (title == 'Daily Deals')
        return product.dailyDealsItems.length;
      else   
        return product.trendingsItems.length;
    }

    // get the date of selected list depend on type
    String getListData(product, index, type){
      if (categoryId != 0){
        if (type == 'title')
          return product.items[index].title;
        else if (type == 'imageUrl')
          return product.items[index].imageUrl;
        else if (type == 'price')
          return product.items[index].price;
        else 
          return product.items[index].id.toString();    
      } 
      else if (title == 'Daily Deals'){
        if (type == 'title')
          return product.dailyDealsItems[index].title;
        else if (type == 'imageUrl')
          return product.dailyDealsItems[index].imageUrl;
        else if (type == 'price')
          return product.dailyDealsItems[index].price;
        else 
          return product.dailyDealsItems[index].id.toString();  
      } 
      else {  
        if (type == 'title')
          return product.trendingsItems[index].title;
        else if (type == 'imageUrl')
          return product.trendingsItems[index].imageUrl;
        else if (type == 'price')
          return product.trendingsItems[index].price;
        else 
          return product.trendingsItems[index].id.toString();  
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        iconButton: true,
        title: title,
      ),
      body: FutureBuilder(
        future: findSelectedList(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else {
            if (snapshot.error != null) return Text(snapshot.error.toString());
            else { 
              return Consumer<ProductProvider>(
                builder: (ct, product, _) => GridView.builder(
                  itemCount: getListSize(product),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3/3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                  ),
                  itemBuilder: (cext, index){
                    return InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                        ProductDetailScreen.routeName,
                        arguments: {
                          'title': getListData(product, index, 'title'),
                          'productId': getListData(product, index, 'id'),
                        }
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //product image
                            Image.network(
                              getListData(product, index, 'imageUrl'),
                              width: 120,
                              height: 120,
                            ),

                            //product title
                            Text(
                              getListData(product, index, 'title'),
                              style: TextStyle(fontSize: 16,),
                              maxLines: 1,
                            ),

                            //product price
                            Text(
                              getListData(product, index, 'price'),
                              style: TextStyle(fontSize: 16, ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ); 
                  },  
                ), 
              );
            }
          }
        },
      ),
    );
  }
}
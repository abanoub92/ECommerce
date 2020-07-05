import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/products_screen.dart';
import '../providers/category_provider.dart';

class CategoryItem extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CategoryProvider>(context, listen: false).fetchCategories(),
      builder: (ctx, snapShot){
        if (snapShot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator(),);
        else {
          if (snapShot.error != null) return Text(snapShot.error.toString());
          else {
            return Consumer<CategoryProvider>(
              builder: (ctx, category, _) => Container(
                width: double.infinity,
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.items.length,
                  itemBuilder: (ctx, index){
                    return Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pushNamed(
                          ProductsScreen.routeName,
                          arguments: {
                            'categoryId': category.items[index].id,
                            'title': category.items[index].title
                          }
                        ),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).accentColor,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.network(category.items[index].image, height: 30, width: 30, color: Colors.white,),
                                Text(category.items[index].title, style: TextStyle(fontSize: 12, color: Colors.white))
                              ],
                            ),
                          ),
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
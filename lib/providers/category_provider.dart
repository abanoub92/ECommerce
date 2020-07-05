import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/shared_preference_service.dart';

class Category {

  final int id;
  final String title;
  final String image;

  Category({
    this.id, 
    @required this.title, 
    @required this.image
  });

}

class CategoryProvider with ChangeNotifier {

  List<Category> categories = [];

  List<Category> get items{
    return categories;
  }

  /*
   *
   */
  Future<void> fetchCategories() async {
    final service = await SharedPreferenceService.instance;
    final authToken = json.decode(service.userData)['token'];

    final url = 'https://hypermarket-4ab70.firebaseio.com/categories.json?auth=$authToken';
    //print('categories url is: ' + url);
    final response = await http.get(url);

    try{
      if (response.statusCode == 200){
        //print('categories are: ' + response.body);
        final extractedData = json.decode(response.body) as List<dynamic>;
        //print('categories are: ' + extractedData.toString());
        if (extractedData == null) return;

        List<Category> loadedData = [];
        extractedData.forEach((categoryData) {
          loadedData.add(Category(
            id: categoryData['id'],
            title: categoryData['title'],
            image: categoryData['image'],
          ));
        });

        categories = loadedData;
        notifyListeners();
      }else {
        print('token is: ' + authToken);
        print(response.statusCode);
      }

    } catch(error){
      print(error);
    }
  }
  
}
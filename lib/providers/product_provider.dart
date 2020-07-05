import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../utils/shared_preference_service.dart';

class Product{

  int id;
  String title;
  String description;
  String imageUrl;
  String price;
  bool isDailyDeal;
  bool isTrending;
  int categoryId;

  Product({
    this.id,
    this.title, 
    this.imageUrl, 
    this.price,
    this.isDailyDeal,
    this.isTrending,
    this.categoryId
  });

}

class ProductProvider with ChangeNotifier{

  List<Product> products = [];
  List<Product> dailyDeals = [];
  List<Product> trendings = [];

  List<Product> get items{
    return products;
  }

  List<Product> get dailyDealsItems{
    return dailyDeals;
  }

  List<Product> get trendingsItems{
    return trendings;
  }

  Future<void> fetchProducts(int categoryId) async {
    final service = await SharedPreferenceService.instance;
    final authToken = json.decode(service.userData)['token'];

    final url = 'https://hypermarket-4ab70.firebaseio.com/products.json?orderBy="categoryId"&equalTo=$categoryId&auth=$authToken';
    final response = await http.get(url);

    try{
      if (response.statusCode == 200){
        //print('products are: ' + response.body);
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        if (extractedData == null) return;

        List<Product> loadedData = [];
        extractedData.forEach((prodId, prodData) {
          loadedData.add(Product(
            id: prodData['id'],
            title: prodData['title'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isDailyDeal: prodData['isDailyDeal'],
            isTrending: prodData['isTrending'],
            categoryId: prodData['categoryId']
          ));
        });

        products = loadedData;
        //print('products are: ' + products[0].toString());
        notifyListeners();
      }else {
        print('token is: ' + authToken);
        print(response.statusCode);
      }

    } catch(error){
      print(error);
    }
  }


  Future<void> fetchSpicalProducts(String type) async {
    final service = await SharedPreferenceService.instance;
    final authToken = json.decode(service.userData)['token'];

    final url = 'https://hypermarket-4ab70.firebaseio.com/products.json?orderBy="$type"&equalTo=true&auth=$authToken';
    //print('products url is: ' + url);
    final response = await http.get(url);

    try{
      if (response.statusCode == 200){
        //print('products are: ' + response.body);
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        //print('products are: ' + extractedData.toString());
        if (extractedData == null) return;

        List<Product> loadedData = [];
        extractedData.forEach((prodId, prodData) {
          loadedData.add(Product(
            id: prodData['id'],
            title: prodData['title'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isDailyDeal: prodData['isDailyDeal'],
            isTrending: prodData['isTrending'],
            categoryId: prodData['categoryId']
          ));
        });

        type == 'isDailyDeal' ? dailyDeals = loadedData : trendings = loadedData;
        //print('products are: ' + products[0].toString());
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
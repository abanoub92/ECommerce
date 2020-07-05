import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../utils/shared_preference_service.dart';

class ProductDetail{

  int id;
  String title;
  String description;
  List<String> images;
  String price;
  String oldPrice;
  List<String> sizes;
  List<MyColor> colors;
  Review reviews;
  int categoryId;

  ProductDetail({
    this.id,
    this.title, 
    this.description,
    this.images, 
    this.price,
    this.oldPrice,
    this.sizes,
    this.colors,
    this.reviews,
    this.categoryId
  });

  List<String> get getImages{
    return images;
  }

}

class Review{

  String rateDegree;
  double rateValue;
  int reviewCount;

  Review({
    this.rateDegree,
    this.rateValue,
    this.reviewCount
  });

}

class MyColor{

  final String color;
  final String title;

  MyColor({this.color, this.title});
}

class ProductDetailProvider with ChangeNotifier{

  ProductDetail product = ProductDetail();

  ProductDetail get item{
    return product;
  }

  Future<void> fetchProductDetail(String productId) async {
    final service = await SharedPreferenceService.instance;
    final authToken = json.decode(service.userData)['token'];

    final url = 'https://hypermarket-4ab70.firebaseio.com/product-details/$productId.json?auth=$authToken';
    final response = await http.get(url);

    try{
      if (response.statusCode == 200){
        //print('products are: ' + response.body);
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        //print('products are: ' + extractedData.toString());
        if (extractedData == null) return;

        //print('products are: ' + extractedData.toString());

        // extractedData.forEach((prodId, prodData) {
        //   loadedData = ProductDetail(
        //     id: prodData['id'],
        //     title: prodData['title'],
        //     description: prodData['description'],
        //     images: (prodData['images'] as List<dynamic>).map((image) => image).toList(),
        //     colors: (prodData['colors'] as List<dynamic>).map((color) => MyColor(
        //       color: color['color'],
        //       title: color['title']
        //     )).toList(),
        //     price: prodData['price'],
        //     oldPrice: prodData['oldPrice'],
        //     reviews: (prodData['reviews'] as dynamic).map((review) => Review(
        //       rateDegree: review['rateDegree'],
        //       rateValue: review['rateValue'],
        //       reviewCount: review['reviewCount']
        //     )),
        //     sizes: (prodData['sizes'] as List<dynamic>).map((size) => size).toList(),
        //     categoryId: prodData['categoryId']
        //   );
        // });

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
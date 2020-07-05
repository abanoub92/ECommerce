import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/shared_preference_service.dart';

class Ads {

  final int id;
  final String title;
  final String description;
  final String image;

  Ads({
    this.id, 
    @required this.title,
    @required this.description, 
    @required this.image
  });

}

class AdsProvider with ChangeNotifier {

  List<String> ads = [];

  List<String> get items{
    return ads;
  }

  /*
   *
   */
  Future<void> fetchAds() async {
    final service = await SharedPreferenceService.instance;
    final authToken = json.decode(service.userData)['token'];

    final url = 'https://hypermarket-4ab70.firebaseio.com/ads.json?auth=$authToken';
    final response = await http.get(url);

    try{
      if (response.statusCode == 200){
        //print('ads are: ' + response.body);
        final extractedData = json.decode(response.body) as List<dynamic>;
        //print('ads are: ' + extractedData.toString());
        if (extractedData == null) return;

        List<String> loadedData = [];
        extractedData.forEach((adsData) {
          loadedData.add(
            adsData['image'],
          );
        });

        ads = loadedData;
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
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preference_service.dart';

class UserProvider with ChangeNotifier{

  String _userId;
  String _token;
  DateTime _expireDate;
  String _username;
  String _email;
  String _password;

  bool _isVisible = false;

  void isVisible(bool value){
    _isVisible = value;
    notifyListeners();
  }

  String get token{
    if (_expireDate != null && _expireDate.isAfter(DateTime.now()) && _token != null) return _token; 
    else return null;
  }

  String get userId{
    if (_userId != null) return userId;
    else return null;
  }

  Future<void> _authentication(email, password, urlSegment) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDYy8B063Ec2nT-I_8caHlmRNQgzN-5wpc';

    try {
      final response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      }));

      final responseData = json.decode(response.body);
      if (response.statusCode == 200){
        _token = responseData['idToken'];
        _userId = responseData['localId'];
        _expireDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      }else if (responseData['error'] != null){
        print(responseData['error']['message']);
      }

      notifyListeners();
      final service = await SharedPreferenceService.instance;
      service.setLoginCode(true);
      service.setUserData(json.encode({
        'email': email,
        'password': password,
        'token': _token,
        'userId': _userId,
        'expireData': _expireDate.toIso8601String(),
      }));

      renewAuthToken().then((value) => print('auth token renewed.'));

    } catch(error){
      print(error);
    }
  }

  Future<void> signUp(email, password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<void> signIn(email, password) async {
    return _authentication(email, password, 'signInWithPassword');
  }

  Future<void> renewAuthToken() async {
    final service = await SharedPreferenceService.instance;
    final userData = json.decode(service.userData);
    final expaireDate = DateTime.parse(userData['expireData']);
    
    Future.delayed(Duration(seconds: expaireDate.second))
    .then((_) async {
      print('auth token is expired: ${expaireDate.second}');
      await signIn(userData['email'], userData['password']);
    });

    // if (DateTime.now().isAfter(expaireDate)){
      
    //   return true;
    // }else {
    //   return false; 
    // }
  }
}
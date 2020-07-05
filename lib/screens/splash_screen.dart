import 'package:ecommerce/utils/shared_preference_service.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  Future<bool> _checkForSession() async {
    await Future.delayed(Duration(milliseconds: 5000,), (){});
    final service = await SharedPreferenceService.instance;
    return service.isLogin;
  }

  void _navigateToScreen(routeName){
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  @override
  void initState() {
    _checkForSession().then((status){
      if (status){
        _navigateToScreen(HomeScreen.routeName);
      }else {
        _navigateToScreen(WelcomeScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            child: Image.asset(
              'assets/images/logo_app.png', 
              height: 130, 
              width: 130,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:ecommerce/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/splash_screen.dart';
import './screens/welcome_screen.dart';
import './screens/auth_sign_up_screen.dart';
import './screens/auth_sign_in_screen.dart';
import './screens/home_screen.dart';
import './providers/user_provider.dart';
import './providers/ads_provider.dart';
import './screens/product_detail_screen.dart';
import './providers/category_provider.dart';
import './providers/product_provider.dart';
import './providers/product_detail_provider.dart';


void main(){
  //change status bar color to white
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
  runApp(EcommerceApp());
}

class EcommerceApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CategoryProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AdsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProductDetailProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      
        theme: ThemeData(
          primaryColorLight: Colors.white,
          primaryColorDark: Color(0xff121212),
          accentColor: Color(0xff0579D5),
        ),
        home: SplashScreen(),
        routes: {
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
          AuthSignUpScreen.routeName: (_) => AuthSignUpScreen(),
          AuthSignInScreen.routeName: (_) => AuthSignInScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
          ProductsScreen.routeName: (_) => ProductsScreen(),
          ProductDetailScreen.routeName: (_) => ProductDetailScreen()
        },
      ),
    );
  }
}
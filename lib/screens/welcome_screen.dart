import 'package:flutter/material.dart';

import '../screens/auth_sign_up_screen.dart';
import '../screens/auth_sign_in_screen.dart';
import '../widgets/gradient_raised_button.dart';

class WelcomeScreen extends StatelessWidget {

  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Welcome to Black Market', 
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Explore Us', 
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Image.asset('assets/images/logo_welcome.png', fit: BoxFit.contain,)),
            Column(
              children: <Widget>[
                GradientRaisedButton(
                  onPressed: () => Navigator.of(context).pushNamed(AuthSignInScreen.routeName),
                  child: Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16),),
                  gradient: LinearGradient(colors: <Color>[
                    Color(0xff0579D5),
                    Color(0xff0490FF),
                  ]),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pushNamed(AuthSignUpScreen.routeName), 
                  child: Text(
                    'Sign Up', 
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor),
                    ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
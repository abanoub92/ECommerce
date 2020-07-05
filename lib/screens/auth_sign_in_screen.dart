import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../screens/auth_sign_up_screen.dart';
import '../screens/home_screen.dart';
import '../providers/user_provider.dart';
import '../widgets/gradient_raised_button.dart';
import '../utils/shared_preference_service.dart';

class AuthSignInScreen extends StatelessWidget {

  static const routeName = '/authSignin';

  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _toggle = false;

  Map<String, String> _signInData = {
    'email': '',
    'password': ''
  };

  void _submitSignIn(context) async {
    if (!_formKey.currentState.validate()){
      //invalid
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<UserProvider>(context, listen: false).signIn(
        _signInData['email'],
        _signInData['password']
      ).then((_) async {
        final service = await SharedPreferenceService.instance;
        service.setLoginCode(true);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      });
    } catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black,), 
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Sign in', style: TextStyle(fontSize: 36),),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    //email input
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                      validator: (value){
                        if (value.isEmpty || !value.contains('@')) return 'Invalid Email';
                        else return null;
                      },
                      onSaved: (email){
                        _signInData['email'] = email;
                      },
                    ),

                    //password input
                    Consumer<UserProvider>(
                      builder: (ctx, user, ch) => Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Password'),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _toggle,
                                focusNode: _passwordFocusNode,
                                onFieldSubmitted: (_){},
                                validator: (value){
                                  if (value.isEmpty || value.length < 6) return 'Invalid password (too short).';
                                  else return null;
                                },
                                onSaved: (password){
                                  _signInData['password'] = password;
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(_toggle ? Icons.visibility_off : Icons.visibility, color: Colors.grey,), 
                              onPressed: () {
                                user.isVisible(_toggle);
                                _toggle = !_toggle;
                              }
                            ),
                          ],
                        ),
                      ),
                    ),

                    //sign in button
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
                      child: GradientRaisedButton(
                        onPressed: () => _submitSignIn(context), 
                        child: Text('Sign in', style: TextStyle(color: Colors.white, fontSize: 16),),
                        gradient: LinearGradient(colors: <Color>[
                          Color(0xff0579D5),
                          Color(0xff0490FF),
                        ]),
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Don\'t have an account?'),
                        FlatButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed(AuthSignUpScreen.routeName), 
                          child: Text('Sign up', style: TextStyle(color: Theme.of(context).accentColor),),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}
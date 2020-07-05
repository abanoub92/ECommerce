import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/gradient_raised_button.dart';
import '../screens/auth_sign_in_screen.dart';
import '../providers/user_provider.dart';
import '../screens/home_screen.dart';
import '../utils/shared_preference_service.dart';

class AuthSignUpScreen extends StatelessWidget {

  static const routeName = '/authSignup';

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  bool _toggle = false;
  bool _toggleTwo = false;

  Map<String, String> _signUpData = {
    'name': '',
    'email': '',
    'password': ''
  };

  void _submitSignUp(context) async {
    if (!_formKey.currentState.validate()){
      //invalid
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<UserProvider>(context, listen: false).signUp(
        _signUpData['email'],
        _signUpData['password']
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
              child: Text('Sign up', style: TextStyle(fontSize: 36),),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    //name input
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocusNode),
                      validator: (value){
                        if (value.isEmpty || value.length <= 1) return 'You must enter valid name';
                        else return null;
                      },
                      onSaved: (name){
                        _signUpData['name'] = name;
                      },
                    ),

                    //email input
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFocusNode,
                        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                        validator: (value){
                          if (value.isEmpty || !value.contains('@'))
                            return 'Invalid Email';
                          else return null;
                        },
                        onSaved: (email){
                          _signUpData['email'] = email;
                        },
                      ),
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
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmPasswordFocusNode),
                                validator: (value){
                                  if (value.isEmpty || value.length < 6) return 'Invalid password (too short).';
                                  else return null;
                                },
                                onSaved: (password){
                                  _signUpData['password'] = password;
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(_toggle ? Icons.visibility_off : Icons.visibility, color: Colors.grey,), 
                              onPressed: (){
                                user.isVisible(_toggle);
                                _toggle = !_toggle;
                              })
                          ],
                        ),
                      ),
                    ),

                    //confirm password input
                    Consumer<UserProvider>(
                      builder: (ctx, user, ch) => Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Confirm Password'),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _toggleTwo,
                                focusNode: _confirmPasswordFocusNode,
                                onFieldSubmitted: (_){},
                                validator: (value){
                                  if (value != _passwordController.text) return 'Password do not match!';
                                  else return null;
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.visibility_off, color: Colors.grey,), 
                              onPressed: (){
                                user.isVisible(_toggleTwo);
                                _toggleTwo = !_toggleTwo;
                              }
                            )
                          ],
                        ),
                      ),
                    ),

                    //sign up button
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
                      child: GradientRaisedButton(
                        onPressed: () => _submitSignUp(context), 
                        child: Text('Sign up', style: TextStyle(color: Colors.white, fontSize: 16),),
                        gradient: LinearGradient(colors: <Color>[
                          Color(0xff0579D5),
                          Color(0xff0490FF),
                        ]),
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Already have an account?'),
                        FlatButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed(AuthSignInScreen.routeName), 
                          child: Text('Sign in', style: TextStyle(color: Theme.of(context).accentColor),),
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
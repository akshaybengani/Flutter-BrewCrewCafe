import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:brew_crew_cafe/screens/registerscreen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static const routename = '/signinscreen';
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: 'Welcome to\n'),
                    TextSpan(
                      text: 'Brew Crew\n',
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'Cafe'),
                  ],
                ),
              ),
              Divider(
                thickness: 5,
                color: theme.accentColor,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: theme.primaryColor)),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: theme.primaryColor,
                        decoration: InputDecoration(
                            icon: Icon(Icons.email), labelText: 'Email'),
                      ),
                      TextFormField(
                        obscureText: true,
                        cursorColor: theme.primaryColor,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock), labelText: 'Password'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(HomePageScreen.routename);
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(RegisterScreen.routename);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

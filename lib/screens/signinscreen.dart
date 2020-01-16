import 'package:brew_crew_cafe/screens/coffeeprefscreen.dart';
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
                  style: theme.primaryTextTheme.subhead,
                  children: <TextSpan>[
                    const TextSpan(text: 'Welcome to\n'),
                    TextSpan(
                      text: 'Brew Crew\n',
                      style: theme.primaryTextTheme.headline,
                    ),
                    const TextSpan(text: 'Cafe'),
                  ],
                ),
              ),
              Divider(),
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
                      Text('Login', style: theme.primaryTextTheme.body1),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.email), labelText: 'Email'),
                      ),
                      TextFormField(
                        obscureText: true,
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
                              child: Text('LOGIN'),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    CoffeePrefScreen.routename);
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              child: Text('REGISTER'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routename);
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

import 'package:brew_crew_cafe/backend/loginchecker.dart';
import 'package:brew_crew_cafe/screens/coffeeprefscreen.dart';
import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:brew_crew_cafe/screens/registerscreen.dart';
import 'package:brew_crew_cafe/screens/signinscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brew Crew Cafe',
      theme: ThemeData(
        primaryColor: Colors.brown[800],
        accentColor: Colors.brown[300],
        backgroundColor: Colors.brown[100],
        appBarTheme: AppBarTheme(
          color: Colors.brown[800],
          textTheme: TextTheme(
            // Add Fonts and set Font style
            title: TextStyle(color: Colors.white),
          ),
        ),
        buttonTheme: ButtonThemeData(buttonColor: Colors.brown[800]),
        cardTheme: CardTheme(color: Colors.white),        
      ),
      home: LoginChecker(),
      routes: {
        SignInScreen.routename : (ctx) => SignInScreen(),
        RegisterScreen.routename: (ctx) => RegisterScreen(),
        HomePageScreen.routename: (ctx) => HomePageScreen(),
        CoffeePrefScreen.routename: (ctx) => CoffeePrefScreen(),
      }
    );
  }
}









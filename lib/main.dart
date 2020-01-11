import 'package:brew_crew_cafe/backend/loginchecker.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        buttonColor: Colors.brown[600],
        cardTheme: CardTheme(color: Colors.white),        
      ),
      home: LoginChecker(),
    );
  }
}

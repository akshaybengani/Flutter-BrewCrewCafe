import 'package:brew_crew_cafe/screens/brewdrawer.dart';
import 'package:brew_crew_cafe/screens/coffeeprefscreen.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatelessWidget {
  static const routename = '/homepagescreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BrewDrawer(),
      appBar: AppBar(
        title: Text(
          'Brew Crew Cafe',
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.edit),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(CoffeePrefScreen.routename);
            },
            label: Text('Edit'),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

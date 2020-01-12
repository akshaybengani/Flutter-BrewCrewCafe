import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:flutter/material.dart';

class CoffeePrefScreen extends StatefulWidget {
  static const routename = '/coffeeprefscreen';

  @override
  _CoffeePrefScreenState createState() => _CoffeePrefScreenState();
}

class _CoffeePrefScreenState extends State<CoffeePrefScreen> {
  int _coffeeIntensity;
  int _sugarIntensity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 2, color: Theme.of(context).primaryColor),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Text(
                  'Choose Your Coffee Intensity',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Slider(
                min: 100,
                max: 900,
                divisions: 8,
                inactiveColor: Colors.brown[100],
                activeColor: Colors.brown[_coffeeIntensity ?? 100],
                onChanged: (val) {
                  setState(() {
                    _coffeeIntensity = val.round();
                  });
                },
                value: (_coffeeIntensity ?? 100).toDouble(),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: Text(
                  'Choose Your Sugar Intensity',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Slider(
                min: 0,
                max: 5,
                divisions: 5,
                inactiveColor: Colors.amber,
                activeColor: Colors.amber[
                    (_sugarIntensity * 100) == 0 ? 100 : _sugarIntensity * 100],
                onChanged: (val) {
                  setState(() {
                    _sugarIntensity = val.round();
                  });
                },
                value: (_sugarIntensity ?? 0).toDouble(),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: Text(
                  'Tell us something about your love towards Coffee',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
                alignment: Alignment.topLeft,
                child: TextField(
                  autofocus: true,
                  maxLines: 5,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(labelText: 'About Coffee'),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  "Let's Brew It",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(HomePageScreen.routename);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

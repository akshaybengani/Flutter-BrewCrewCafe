import 'package:flutter/material.dart';

class BrewDrawer extends StatefulWidget {
  @override
  _BrewDrawerState createState() => _BrewDrawerState();
}

class _BrewDrawerState extends State<BrewDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/coffeedrawer.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text('Hi here I am '),
        ],
      ),
    );
  }
}

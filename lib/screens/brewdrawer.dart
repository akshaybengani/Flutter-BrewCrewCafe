import 'package:flutter/material.dart';

class BrewDrawer extends StatefulWidget {
  @override
  _BrewDrawerState createState() => _BrewDrawerState();
}

class _BrewDrawerState extends State<BrewDrawer> {

  bool checkAdmin(){
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //  App Drawer Header image installation
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/coffeedrawer.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.brown[700], fontSize: 30),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Welcome\n',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      TextSpan(
                          text: 'Akshay Bengani',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                    'I am a coffee lover and I want to taste every kind of coffee available in market'),
                SizedBox(height: 5),
                ListTile(
                  onTap: (){},
                  leading: Icon(
                    Icons.add_box,
                    color: Colors.brown[800],
                  ),
                  title: Text('Share Your Crew'),
                ),
                ListTile(
                  onTap: (){},
                  leading: Icon(
                    Icons.share,
                    color: Colors.brown[800],
                  ),
                  title: Text('Share Brew Crew Cafe'),
                ),
                
                checkAdmin() ?
                ListTile(
                  onTap: (){},
                  leading: Icon(
                    Icons.edit,
                    color: Colors.brown[800],
                  ),
                  title: Text('Manage Crew'),
                )
                :
                ListTile(
                  onTap: (){},
                  leading: Icon(
                    Icons.email,
                    color: Colors.brown[800],
                  ),
                  title: Text('Contact Crew Captain'),
                ),

                ListTile(
                  onTap: (){},
                  leading: Icon(
                    Icons.person,
                    color: Colors.brown[800],
                  ),
                  title: Text('Log out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

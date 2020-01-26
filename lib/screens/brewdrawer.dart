import 'package:brew_crew_cafe/backend/authprovider.dart';
import 'package:brew_crew_cafe/screens/managecrewscreen.dart';
import 'package:brew_crew_cafe/screens/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class BrewDrawer extends StatelessWidget {
  static const routename = '/brewdrawer';

  @override
  Widget build(BuildContext context) {
    final String shareMessage =
        'Hey!! Join us on Brew Crew Cafe, https://play.google.com/store/apps/details?id=com.akshaybengani.brewcrewcafe \nAn app for coffee enthusiasts, Use this crew code to join the revolution.';
    
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
                  onTap: () {
                    //  Add Crew ID with it
                    Share.share(shareMessage);
                  },
                  leading: Icon(Icons.add_box, color: Colors.brown[800]),
                  title: Text('Share Your Crew'),
                ),
                ListTile(
                  onTap: () {
                    //  Update the share message for the App Sharing
                    Share.share(shareMessage);
                  },
                  leading: Icon(Icons.share, color: Colors.brown[800]),
                  title: Text('Share Brew Crew Cafe'),
                ),
                AdminListTile(),
                ListTile(
                  onTap: () {                 
                    Provider.of<AuthProvider>(context,listen: false).signOut();
                    Navigator.of(context).pop();
                  },
                  leading: Icon(Icons.person, color: Colors.brown[800]),
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

class AdminListTile extends StatefulWidget {
  @override
  _AdminListTileState createState() => _AdminListTileState();
}

class _AdminListTileState extends State<AdminListTile> {
  bool checkAdmin() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return checkAdmin()
        ? ListTile(
            onTap: () {
              Navigator.of(context).popAndPushNamed(ManageCrewScreen.routename);
            },
            leading: Icon(Icons.edit, color: Colors.brown[800]),
            title: Text('Manage Crew'),
          )
        : ListTile(
            onTap: () {},
            leading: Icon(Icons.email, color: Colors.brown[800]),
            title: Text('Contact Crew Captain'),
          );
  }
}

import 'package:brew_crew_cafe/screens/managecrewscreen.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BrewDrawer extends StatefulWidget {
  static const routename = '/brewdrawer';

  @override
  _BrewDrawerState createState() => _BrewDrawerState();
}

class _BrewDrawerState extends State<BrewDrawer> {
  bool checkAdmin() {
    return true;
  }

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
                    // TODO Add Crew ID with it
                    Share.share(shareMessage);
                  },
                  leading: Icon(Icons.add_box),
                  title: Text('Share Your Crew'),
                ),
                ListTile(
                  onTap: () {
                    // TODO Update the share message for the App Sharing
                    Share.share(shareMessage);
                  },
                  leading: Icon(Icons.share),
                  title: Text('Share Brew Crew Cafe'),
                ),
                checkAdmin()
                    ? ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .popAndPushNamed(ManageCrewScreen.routename);
                        },
                        leading: Icon(Icons.edit),
                        title: Text('Manage Crew'),
                      )
                    : ListTile(
                        onTap: () {},
                        leading: Icon(Icons.email),
                        title: Text('Contact Crew Captain'),
                      ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.person),
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

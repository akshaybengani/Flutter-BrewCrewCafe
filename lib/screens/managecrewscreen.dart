import 'package:brew_crew_cafe/layouts/usermanagetile.dart';
import 'package:brew_crew_cafe/models/crewuser.dart';
import 'package:brew_crew_cafe/providers/crewprovider.dart';
import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCrewScreen extends StatefulWidget {
  static const routename = '/managecrew';

  @override
  _ManageCrewScreenState createState() => _ManageCrewScreenState();
}

class _ManageCrewScreenState extends State<ManageCrewScreen> {
  bool _isLoading = false;
  String loadingMsg = "";

  Future<void> _attemptToDeleteMember(CrewUser crewUser) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Remove ${crewUser.name}'),
        content: Text(
            'Are you sure you want to Delete ${crewUser.name} from ${crewUser.crewname}.'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Colors.brown[800],
            width: 5,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'DELETE',
              style: TextStyle(
                color: Colors.brown,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop;
              _deleteCrewMember();
            },
          ),
          FlatButton(
            child: Text(
              'CANCEL',
              style: TextStyle(
                color: Colors.brown,
              ),
            ),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
    );
  }

  Future<void> _deleteCrewMember() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Feature In Development'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Colors.brown[800],
            width: 5,
          ),
        ),
        content: Text(
          'Hi, currently at this version we dont provide the feature to delete crew members\nWe will definately add this feature in our next update\nWe our sorry for the inconvience. Stay tuned to Brew Crew Cafe and enjoy your coffee delight.',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: Navigator.of(ctx).pop,
            child: Text('Okay',
                style: TextStyle(color: Colors.brown[800], fontSize: 20)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<CrewProvider>(context, listen: false).providerCurrentUser;
    final crewExceptCaptain = Provider.of<CrewProvider>(context, listen: true)
        .crewExceptCaptain(currentUser.authid);

    return WillPopScope(
      onWillPop: () =>
          Navigator.of(context).popAndPushNamed(HomePageScreen.routename),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Welcome Captain'),
                      TextSpan(
                        text: '\n${currentUser.name}',
                        style:
                            TextStyle(fontSize: 40, color: Colors.brown[800]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Over here you can remove crew members or delete your brew crew team.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ListView.builder(
                    itemCount: crewExceptCaptain.length,
                    // ! Below is the card
                    itemBuilder: (context, index) => Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.brown[800]),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        // contentPadding: EdgeInsets.all(10),
                        title: Text(
                          crewExceptCaptain[index].name,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.brown[800],
                          ),
                          onPressed: () {
                            _attemptToDeleteMember(crewExceptCaptain[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Are you sure you want to delete'),
                        content: Text(
                            'This will delete all your crew members and their coffee preferences.'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.brown[800],
                            width: 5,
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                color: Colors.brown,
                              ),
                            ),
                            onPressed: Navigator.of(context).pop,
                          ),
                          FlatButton(
                            child: Text(
                              'DELETE',
                              style: TextStyle(
                                color: Colors.brown,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop;
                              _deleteCrewMember();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                        width: 5,
                      ),
                    ),
                    child: Text(
                      'Delete Crew & All Crew Members',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

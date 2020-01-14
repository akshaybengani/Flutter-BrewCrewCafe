import 'package:brew_crew_cafe/backend/crewprovider.dart';
import 'package:brew_crew_cafe/layouts/usermanagetile.dart';
import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCrewScreen extends StatelessWidget {
  static const routename = '/managecrew';

  @override
  Widget build(BuildContext context) {
    final crewProd = Provider.of<CrewProvider>(context);
    final crewExceptCaptain = crewProd.crewExceptCaptain('001');

    return WillPopScope(
      onWillPop: () => Navigator.of(context).popAndPushNamed(HomePageScreen.routename),
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
                        text: '\nAkshay Bengani',
                        style: TextStyle(fontSize: 40, color: Colors.brown[800]),
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
                    itemBuilder: (context, index) => UserManageTile(
                      name: crewExceptCaptain[index].name,
                      authID: crewExceptCaptain[index].authID,
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
                              // TODO Add some delete function code here
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

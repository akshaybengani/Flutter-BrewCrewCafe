import 'package:brew_crew_cafe/layouts/crewpreftile.dart';
import 'package:brew_crew_cafe/layouts/custominfodialog.dart';
import 'package:brew_crew_cafe/models/crewuser.dart';
import 'package:brew_crew_cafe/providers/authprovider.dart';
import 'package:brew_crew_cafe/providers/crewprovider.dart';
import 'package:brew_crew_cafe/providers/databaseprovider.dart';
import 'package:brew_crew_cafe/screens/brewdrawer.dart';
import 'package:brew_crew_cafe/screens/coffeeprefscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class HomePageScreen extends StatefulWidget {
  static const routename = '/homepagescreen';

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool _isLoading = true;
  bool syncProgressIndicator = false;
  final String shareMessage =
      'Hey!! Join us on Brew Crew Cafe,\nhttps://play.google.com/store/apps/details?id=com.akshaybengani.brewcrewcafe \n\nAn app for coffee enthusiasts, Use this crew code below to join the revolution.\n';
  CrewUser currentUser;

  @override
  void initState() {
    super.initState();
    fetchDataFromLocalToList();
  }

  void fetchDataFromLocalToList() async {
    List<CrewUser> crewlist =
        await Provider.of<DatabaseProvider>(context, listen: false)
            .getCrewList();
    Provider.of<CrewProvider>(context, listen: false)
        .setLocalListFromDatabase(crewlist);
    String authid = await Provider.of<AuthProvider>(context, listen: false)
        .getCurrentUser();
    Provider.of<CrewProvider>(context, listen: false).findByAuthId(authid);
    currentUser =
        Provider.of<CrewProvider>(context, listen: false).providerCurrentUser;

    setState(() {
      _isLoading = false;
    });
  }

  void syncCrewListWithCloud() async {
    print('I just pressed the sync button');
    setState(() {
      syncProgressIndicator = true;
    });

    List<CrewUser> crewlist =
        await Provider.of<CrewProvider>(context, listen: false)
            .fetchCrewMembersFromCloud(currentUser.authid);
    await Provider.of<DatabaseProvider>(context, listen: false).deleteRows();
    int status = await Provider.of<DatabaseProvider>(context, listen: false)
        .insertCrewMembers(crewlist);
    if (status == 0) {
      CustomInfoDialog.showInfoDialog(
          title: 'Problem Occured',
          ctx: context,
          message: 'Some Internal problem occured please reinstall the app');
      setState(() {
        syncProgressIndicator = false;
      });
      return;
    } else {
      setState(() {
        syncProgressIndicator = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final crewData = Provider.of<CrewProvider>(context, listen: true).crewlist;

    return _isLoading
        ? Scaffold(
            appBar: AppBar(
              title: Text('Brewing your crew'),
            ),
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            drawer: BrewDrawer(),
            appBar: AppBar(
              title: Text('Brew it ☕'),
              actions: <Widget>[
                !syncProgressIndicator
                    ? FlatButton.icon(
                        icon: Icon(Icons.sync, color: Colors.white),
                        label: Text(
                          'Sync',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: syncCrewListWithCloud,
                      )
                    : IconButton(
                        icon: Icon(Icons.sync),
                        color: Colors.white,
                        onPressed: () {}),
                FlatButton.icon(
                  icon: Icon(Icons.edit, color: Colors.white),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed(CoffeePrefScreen.routename);
                  },
                  label: Text('Edit'),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          currentUser.crewname,
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.share,
                          color: Colors.brown[800],
                        ),
                        onPressed: () {
                          Share.share('$shareMessage \n${currentUser.crewid}');
                        },
                        label: Text(
                          'Invite',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: ListView.builder(
                      itemCount: crewData.length,
                      itemBuilder: (context, index) => CrewPrefTile(
                        name: crewData[index].name,
                        bio: crewData[index].bio,
                        coffeeIntensity: crewData[index].coffeeintensity,
                        sugarIntensity: crewData[index].sugarintensity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

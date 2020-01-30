import 'package:brew_crew_cafe/models/crewuser.dart';
import 'package:brew_crew_cafe/providers/crewprovider.dart';
import 'package:brew_crew_cafe/providers/databaseprovider.dart';
import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeePrefScreen extends StatefulWidget {
  static const routename = '/coffeeprefscreen';

  @override
  _CoffeePrefScreenState createState() => _CoffeePrefScreenState();
}

class _CoffeePrefScreenState extends State<CoffeePrefScreen> {
  int _coffeeIntensity;
  int _sugarIntensity = 1;
  CrewUser currentUser;
  bool _isLoading = false;
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    currentUser =
        Provider.of<CrewProvider>(context, listen: false).providerCurrentUser;
    _coffeeIntensity = currentUser.coffeeintensity;
    _sugarIntensity = currentUser.sugarintensity;
    _bioController = TextEditingController(text: currentUser.bio);
  }

  Future<void> _saveCoffeePref() async {
    CrewUser newData = CrewUser(
      authid: currentUser.authid,
      bio: _bioController.text,
      coffeeintensity: _coffeeIntensity,
      sugarintensity: _sugarIntensity,
      crewadmin: currentUser.crewadmin,
      crewid: currentUser.crewid,
      crewname: currentUser.crewname,
      name: currentUser.name,
    );

    setState(() {
      _isLoading = true;
    });

    String updateRes =
        await Provider.of<CrewProvider>(context, listen: false).updateUserPref(newData);
    print(updateRes);

    await Provider.of<DatabaseProvider>(context, listen: false).updateUserPref(newData);
    print('Update pref set');

    Navigator.of(context).pushReplacementNamed(HomePageScreen.routename);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin:
                    EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Choose Your Coffee Intensity',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                      activeColor: Colors.brown[_coffeeIntensity*100 ?? 100],
                      onChanged: (val) {
                        setState(() {
                          _coffeeIntensity = (val.round()~/100).toInt();
                        });
                      },
                      value: (_coffeeIntensity*100 ?? 100).toDouble(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: Text(
                        'Choose Your Sugar Intensity',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                      activeColor: Colors.amber[(_sugarIntensity * 100) == 0
                          ? 100
                          : _sugarIntensity * 100],
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                        // autofocus: true,
                        maxLines: 5,
                        controller: _bioController,
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
                      onPressed: _saveCoffeePref,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

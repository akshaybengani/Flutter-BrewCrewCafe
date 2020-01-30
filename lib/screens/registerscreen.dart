import 'package:brew_crew_cafe/layouts/custominfodialog.dart';
import 'package:brew_crew_cafe/models/crewuser.dart';
import 'package:brew_crew_cafe/providers/authprovider.dart';
import 'package:brew_crew_cafe/providers/crewprovider.dart';
import 'package:brew_crew_cafe/providers/databaseprovider.dart';
import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:brew_crew_cafe/screens/signinscreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_cafe/layouts/errormsgmaker.dart';
import 'package:shortid/shortid.dart';

class RegisterScreen extends StatefulWidget {
  static const routename = '/registerscreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool newTeamToggle = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _crewNameController = TextEditingController();
  final _crewIdController = TextEditingController();

  bool _isLoading = false;
  String loadingMsg = "";

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
    'crewname': '',
    'crewid': '',
  };

  // Future<void> _registerBtnPressed() async {
  //   print('Register Button Pressed');
  //   if (!_formKey.currentState.validate()) return;
  //   _formKey.currentState.save();

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   //? Check for toggle and crewid is existed or not
  //   if (!newTeamToggle) {
  //     print('Got inside the initial credid check house');
  //     int existStatus = await Provider.of<CrewProvider>(context, listen: false)
  //         .checkCrewIDExist(crewid: _authData['crewid']);
  //     if (existStatus == 0) {
  //       print('Exit Status is :$existStatus');
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print('now exiting');
  //       return;
  //       print('This should not print');
  //     }
  //     print('This should also not print');
  //   }
  //   print('This should also also not print');

  //   // ! Signup process started

  //   print('Now lets go for signup');
  //   String authid = await Provider.of<AuthProvider>(context, listen: false)
  //       .signUpWithEmail(
  //           email: _authData['email'], password: _authData['password'])
  //       .catchError((onError) {
  //     print(onError);
  //     String emsg = ErrorMsgMaker.msgMaker(error: onError.toString());
  //     print(emsg);
  //     CustomInfoDialog.showInfoDialog(
  //       title: 'Registration Failed!',
  //       ctx: context,
  //       message: emsg,
  //     );
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print('everything now finished with errors');
  //     return;
  //   });

  //   // ! He wants to build a new team.

  //   if (newTeamToggle) {
  //     print('Came inside the newTeam formation system function');
  //     String newId = _authData['crewname'] + shortid.generate();
  //     print(newId);

  //     CrewUser crewUser =
  //         await Provider.of<CrewProvider>(context, listen: false)
  //             .addNewCrewNodes(
  //       authid: authid,
  //       crewid: newId,
  //       crewname: _authData['crewname'],
  //       username: _authData['name'],
  //     )
  //             .catchError((error) {
  //       String emsg = ErrorMsgMaker.msgMaker(error: error.toString());
  //       print(emsg);
  //       CustomInfoDialog.showInfoDialog(
  //           title: 'Problem Occured', ctx: context, message: emsg);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       return;
  //     });

  //     print('Came at the position to add a list item');
  //     List<CrewUser> list = List<CrewUser>();
  //     list.add(crewUser);

  //     int status = await Provider.of<DatabaseProvider>(context, listen: false)
  //         .insertCrewMembers(list);
  //     if (status == 0) {
  //       CustomInfoDialog.showInfoDialog(
  //           title: 'Problem Occured',
  //           ctx: context,
  //           message: 'Some Internal problem occured please reinstall the app');
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       return;
  //     }

  //     setState(() {
  //       _isLoading = false;
  //     });
  //     Navigator.of(context).pushReplacementNamed(HomePageScreen.routename);
  //   }

  //   // ! Case when user uses existing crewid

  //   if (!newTeamToggle) {
  //     print('When the user didnt changed and keep on existing');
      
  //   }
  // }

  Future<void> _joinYourCrew() async {
    print('Join Your Crew Button Pressed');
    if(!_formKey.currentState.validate()){
      print('Form Keys Are Not Valid');
      return;
    }
    print('Validator Validated the form keys');
    _formKey.currentState.save();
    print('Form state is now saved');
    setState(() {
      _isLoading = true;
    });

    // ? Checking EnteredCrewId exists or not
    int existStatus = await Provider.of<CrewProvider>(context, listen: false)
          .checkCrewIDExist(crewid: _authData['crewid']);
    if(existStatus == 0){
      setState(() {
        _isLoading = false;
      });
      CustomInfoDialog.showInfoDialog(ctx: context, );
    } else {

    }

  }
  
  Future<void> _startYourCrew() async {
    print('Start Your Crew Button Pressed');
    if(!_formKey.currentState.validate()){
      print('Form Keys Are Not Valid');
      return;
    }
    print('Validator Validated the form keys');
    _formKey.currentState.save();
    print('Form state is now saved');
    setState(() {
      _isLoading = true;
    });




  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: Column(
                children: <Widget>[
                  Text(loadingMsg, style: theme.primaryTextTheme.subhead),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: theme.primaryTextTheme.subhead,
                        children: <TextSpan>[
                          const TextSpan(text: 'Welcome to\n'),
                          TextSpan(
                            text: 'Brew Crew\n',
                            style: theme.primaryTextTheme.headline,
                          ),
                          const TextSpan(text: 'Cafe'),
                        ],
                      ),
                    ),
                    Divider(),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 2, color: theme.primaryColor),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text('Register New User',
                                    style: theme.primaryTextTheme.body1),
                                const SizedBox(height: 20),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Please enter your name";
                                  },
                                  onSaved: (value) {
                                    _authData['name'] = value;
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.person,
                                          color: Colors.brown[800]),
                                      labelText: 'Name'),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        value.length < 5 ||
                                        !value.contains('@'))
                                      return "Invalid Email Format";
                                  },
                                  onSaved: (value) {
                                    _authData['email'] = value;
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.email,
                                          color: Colors.brown[800]),
                                      labelText: 'Email'),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 5)
                                      return "Password Format Invalid";
                                  },
                                  onSaved: (value) {
                                    _authData['password'] = value;
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.lock,
                                          color: Colors.brown[800]),
                                      labelText: 'Password'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          !newTeamToggle
                              ? Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 2,
                                            color: theme.primaryColor),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Text('Crew Details',
                                              style:
                                                  theme.primaryTextTheme.body1),
                                          const SizedBox(height: 20),
                                          const Text(
                                              'Enter Your Crew ID received from your \nCrew or Captain'),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value.isEmpty ||
                                                        value.length > 32)
                                                      return "Invalid CrewId Format";
                                                  },
                                                  onSaved: (value) {
                                                    _authData['crewid'] = value;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                          icon:
                                                              Icon(Icons.group),
                                                          labelText: 'Crew ID'),
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.content_paste),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 20),
                                          RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                newTeamToggle = !newTeamToggle;
                                              });
                                            },
                                            child: const Text(
                                                'Create a New Brew Crew Team'),
                                          )

                                          // ...
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: RaisedButton(
                                            child: const Text('LOGIN'),
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  SignInScreen.routename);
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: RaisedButton(
                                            child: const Text('JOIN YOUR CREW'),
                                            onPressed: _joinYourCrew,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                )
                              : Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 2,
                                            color: theme.primaryColor),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Text('New Crew Details',
                                              style:
                                                  theme.primaryTextTheme.body1),
                                          const SizedBox(height: 20),
                                          const Text(
                                              'To create your own brew crew team,\nEnter your Crew team name'),
                                          TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  value.length > 32)
                                                return "Invalid Crew Name Format";
                                            },
                                            onSaved: (value) {
                                              _authData['crewname'] = value;
                                            },
                                            decoration: const InputDecoration(
                                                icon: Icon(Icons.group),
                                                labelText: 'Unique Crew Name'),
                                          ),
                                          const SizedBox(height: 20),
                                          RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                newTeamToggle = !newTeamToggle;
                                              });
                                            },
                                            child: const Text(
                                                'Join your existing Crew'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: RaisedButton(
                                            child: const Text('LOGIN'),
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  SignInScreen.routename);
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: RaisedButton(
                                            child: const Text('START YOUR CREW'),
                                            onPressed: _startYourCrew,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

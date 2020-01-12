import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:brew_crew_cafe/screens/signinscreen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const routename = '/registerscreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool newTeamToggle = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: 'Welcome to\n'),
                    TextSpan(
                      text: 'Brew Crew\n',
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'Cafe'),
                  ],
                ),
              ),
              Divider(
                thickness: 5,
                color: theme.accentColor,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: theme.primaryColor),
                ),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Register New User',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: theme.primaryColor,
                        decoration: InputDecoration(
                            icon: Icon(Icons.person), labelText: 'Name'),
                      ),
                      TextFormField(
                        cursorColor: theme.primaryColor,
                        decoration: InputDecoration(
                            icon: Icon(Icons.email), labelText: 'Email'),
                      ),
                      TextFormField(
                        obscureText: true,
                        cursorColor: theme.primaryColor,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock), labelText: 'Password'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              !newTeamToggle
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: theme.primaryColor),
                      ),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Crew Details',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // ...

                            SizedBox(height: 20),
                            Text(
                                'Enter Your Crew ID received from your \nCrew or Captain'),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    onTap: () {},
                                    cursorColor: theme.primaryColor,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.group),
                                        labelText: 'Crew ID'),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.content_paste),
                                  onPressed: () {},
                                ),
                              ],
                            ),

                            SizedBox(height: 20),
                            RaisedButton(
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  newTeamToggle = !newTeamToggle;
                                });
                              },
                              child: Text('Create a New Brew Crew Team'),
                            )

                            // ...
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: theme.primaryColor),
                      ),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'New Crew Details',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // ...

                            SizedBox(height: 20),
                            Text(
                                'To create your own brew crew team,\nEnter your Crew team name'),
                            TextFormField(
                              onTap: () {},
                              cursorColor: theme.primaryColor,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.group),
                                  labelText: 'Unique Crew Name'),
                            ),

                            SizedBox(height: 20),
                            RaisedButton(
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  newTeamToggle = !newTeamToggle;
                                });
                              },
                              child: Text('Join your existing Crew'),
                            )

                            // ...
                          ],
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignInScreen.routename);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(HomePageScreen.routename);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

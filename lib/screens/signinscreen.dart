import 'package:brew_crew_cafe/layouts/custominfodialog.dart';
import 'package:brew_crew_cafe/providers/authprovider.dart';
import 'package:brew_crew_cafe/providers/crewprovider.dart';
import 'package:brew_crew_cafe/screens/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew_cafe/layouts/errormsgmaker.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const routename = '/signinscreen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  String email, password;
  String loadingMsg = "";
  String authid = "";

  // Submit form function when user press the login button
  Future<void> _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    // To save the form State
    _formKey.currentState.save();
    // To Initiate Loading spinner
    setState(() {
      _isLoading = true;
      loadingMsg = "Logging in Please Wait...";
    });
    try {
     await Provider.of<AuthProvider>(context, listen: false)
          .loginWithEmail(email: email, password: password).then((uid){
            setState(() {
              loadingMsg = "Great! Getting your crew members onboard\nPlease Wait...";
              authid = uid;
            });

          }).then((_) async {
              await Provider.of<CrewProvider>(context).fetchCrewMembersFromCloud(authid);
          });


    } catch (e) {
      print(e.toString());
      
      var emsg = ErrorMsgMaker.msgMaker(error: e.toString());
      
      CustomInfoDialog.showInfoDialog(
        title: "Authentication Failed",
        message: emsg,
        ctx: context,
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

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
              _isLoading
                  ? Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text(
                            loadingMsg,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(width: 2, color: theme.primaryColor)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Login', style: theme.primaryTextTheme.body1),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.email,
                                      color: Colors.brown[800]),
                                  labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                email = value;
                              },
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return "Invalid Email Format";
                                }
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.lock,
                                      color: Colors.brown[800]),
                                  labelText: 'Password'),
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                password = value;
                              },
                              validator: (value) {
                                if (value.isEmpty || value.length < 5) {
                                  return "Password it too short.";
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    child: Text('LOGIN'),
                                    onPressed: _submitForm,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    child: Text('REGISTER'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(RegisterScreen.routename);
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

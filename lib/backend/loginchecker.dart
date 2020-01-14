import 'package:brew_crew_cafe/backend/authcrew.dart';
import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:brew_crew_cafe/screens/signinscreen.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGEDIN,
  LOGGEDIN,
}

class LoginChecker extends StatefulWidget {
  final AuthCrew authCrew;
  LoginChecker(this.authCrew);

  @override
  _LoginCheckerState createState() => _LoginCheckerState();
}

class _LoginCheckerState extends State<LoginChecker> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userID = '';

  @override
  void initState() {
    super.initState();
    widget.authCrew.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userID = user.uid;
          authStatus = AuthStatus.LOGGEDIN;
        } else {
          authStatus = AuthStatus.NOT_LOGGEDIN;
        }
      });
    });
  }

  void loginCallback() {
    widget.authCrew.getCurrentUser().then((user) {
      setState(() {
        _userID = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGEDIN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGEDIN;
      _userID = '';
    });
  }

  Widget buildLoadingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          backgroundColor: Colors.brown[800],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(authStatus == AuthStatus.NOT_DETERMINED){
      return buildLoadingScreen();
    }
    else if(authStatus == AuthStatus.NOT_LOGGEDIN){
      return SignInScreen();
    }
    else if(authStatus == AuthStatus.LOGGEDIN){
      return HomePageScreen();
    }
    else{
      return buildLoadingScreen();
    }
  
  }
}

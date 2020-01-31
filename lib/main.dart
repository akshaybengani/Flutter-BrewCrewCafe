import 'package:brew_crew_cafe/screens/contactandsupport.dart';
import 'package:brew_crew_cafe/providers/databaseprovider.dart';
import 'package:brew_crew_cafe/providers/authprovider.dart';
import 'package:brew_crew_cafe/providers/crewprovider.dart';
import 'package:brew_crew_cafe/providers/flagprovider.dart';
import 'package:brew_crew_cafe/screens/brewdrawer.dart';
import 'package:brew_crew_cafe/screens/coffeeprefscreen.dart';
import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:brew_crew_cafe/screens/managecrewscreen.dart';
import 'package:brew_crew_cafe/screens/registerscreen.dart';
import 'package:brew_crew_cafe/screens/signinscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CrewProvider(),
        ),
        ChangeNotifierProvider.value(
          value: FlagProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DatabaseProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brew Crew Cafe',
        theme: ThemeData(
          primaryColor: Colors.brown[800],
          accentColor: Colors.brown[300],
          backgroundColor: Colors.brown[100],
          dividerTheme:
              DividerThemeData(color: Colors.brown[300], thickness: 5),
          cursorColor: Colors.brown[800],

          //iconTheme: IconThemeData(color: Colors.brown[800]),
          //accentIconTheme: IconThemeData(color: Colors.brown[800]),
          //primaryIconTheme: IconThemeData(color: Colors.brown[800]),
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 3),
            ),
          ),
          primaryTextTheme: TextTheme(
            headline: TextStyle(
                fontSize: 50,
                color: Colors.brown[800],
                fontWeight: FontWeight.bold),
            subhead: TextStyle(fontSize: 30, color: Colors.black),
            body1: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            button: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.brown[800],
                fontWeight: FontWeight.bold),
          ),
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.brown[800],
              textTheme: ButtonTextTheme.primary),
          appBarTheme: AppBarTheme(
            color: Colors.brown[800],
            textTheme: TextTheme(
              // Add Fonts and set Font style
              title: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        home: MyHomeApp(),
        //home: SignInScreen(),
        routes: {
          SignInScreen.routename: (ctx) => SignInScreen(),
          RegisterScreen.routename: (ctx) => RegisterScreen(),
          HomePageScreen.routename: (ctx) => HomePageScreen(),
          CoffeePrefScreen.routename: (ctx) => CoffeePrefScreen(),
          ManageCrewScreen.routename: (ctx) => ManageCrewScreen(),
          ContactAndSupport.routename: (ctx) => ContactAndSupport(),
        },
      ),
    );
  }
}

class MyHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkAuthentication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return  HomePageScreen();
            } else {
              return SignInScreen();
            }
          }
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Checking Your Login Status', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> checkAuthentication() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user==null){
      return false;
    } else {
      return true;
    }
  }

}


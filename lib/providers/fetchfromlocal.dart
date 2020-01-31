import 'package:brew_crew_cafe/providers/authprovider.dart';
import 'package:brew_crew_cafe/providers/flagprovider.dart';
import 'package:brew_crew_cafe/screens/homepagescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FetchFromLocal extends StatefulWidget {
  @override
  _FetchFromLocalState createState() => _FetchFromLocalState();
}

class _FetchFromLocalState extends State<FetchFromLocal> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //print('Checking Data Exist Status');
    bool destatus = Provider.of<FlagProvider>(context,listen: false).dataExistStatus;
    //print("Data Exist Status :"+destatus.toString());

    // Data Exist Dont need to fetch again
    if(destatus){
     fetchFromLocalFirst();
    } 
    // Data dont exist fetch first
    else {
      fetchFromServerFirst();
    }

  }


  Future<void> fetchFromLocalFirst() async {

     //print('I am Fetching user id from firebase user using AuthProvider');
     String uid = await Provider.of<AuthProvider>(context, listen: false).getCurrentUser();
     //print("My current user uid:"+uid);
     
     


  }

  Future<void> fetchFromServerFirst() async {


  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Scaffold(
      body: Center(child: CircularProgressIndicator()),
    ) : HomePageScreen();

  }
}
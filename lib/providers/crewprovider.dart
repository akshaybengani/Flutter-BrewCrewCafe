import 'package:brew_crew_cafe/models/crewuser.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CrewProvider with ChangeNotifier {
  List<CrewUser> _crewlist = [
    CrewUser(
      crewid: '01',
      authid: '001',
      crewname: 'Gladiators',
      name: 'Akshay Bengani',
      sugarintensity: 2,
      bio: 'I am a cool Dev geek',
      coffeeintensity: 7,
      crewadmin: "true",
    ),
    CrewUser(
      crewid: '02',
      authid: '002',
      crewname: 'Gladiators',
      name: 'Shivank Gautam',
      sugarintensity: 3,
      bio: 'I am a Awesome Coffee Data Science Engineer',
      coffeeintensity: 6,
      crewadmin: "false",
    ),
    CrewUser(
      crewid: '03',
      authid: '003',
      crewname: 'Gladiators',
      name: 'Aastha Jain',
      sugarintensity: 1,
      bio: 'I am Coffee enthusiast and work for Think Tank Startup',
      coffeeintensity: 3,
      crewadmin: "false",
    ),
    CrewUser(
      crewid: '04',
      authid: '004',
      crewname: 'Gladiators',
      name: 'Namrata Shri',
      sugarintensity: 2,
      bio: 'I am a cool Dev geek',
      coffeeintensity: 7,
      crewadmin: "true",
    ),
    CrewUser(
      crewid: '05',
      authid: '005',
      crewname: 'Gladiators',
      name: 'Prashant Pandey',
      sugarintensity: 3,
      bio: 'I am a Awesome Coffee Data Science Engineer',
      coffeeintensity: 6,
      crewadmin: "false",
    ),
    CrewUser(
      crewid: '06',
      authid: '006',
      crewname: 'Gladiators',
      name: 'Karan Daryani',
      sugarintensity: 1,
      bio: 'I am Coffee enthusiast and work for Think Tank Startup',
      coffeeintensity: 3,
      crewadmin: "false",
    ),
  ];

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  List<CrewUser> get crewlist {
    return _crewlist;
  }

  // This will return the CrewMember detail of provided authID, crew
  CrewUser findByAuthID(String authID) {
    return _crewlist.firstWhere((crew) => crew.authid == authID);
  }

  List<CrewUser> crewExceptCaptain(String authID) {
    final List<CrewUser> mList = _crewlist;
    mList.removeWhere((test) => test.authid == authID);
    return mList;
  }

  Future<List<CrewUser>> fetchCrewMembersFromCloud(String authid) async {
    String crewid = await fetchCrewIdFromAuthID(authid);
    List<CrewUser> crewlist = List<CrewUser>();

    await databaseReference
        .child('BrewCrewCafe/Crews')
        .child(crewid)
        .once()
        .then((DataSnapshot snap) {
      snap.value.forEach((mauthid, data) {
        crewlist.add(CrewUser(
          authid: data['authid'],
          bio: data['bio'],
          coffeeintensity: data['coffeeintensity'],
          crewadmin: data['crewadmin'],
          crewid: data['crewid'],
          crewname: data['crewname'],
          name: data['name'],
          sugarintensity: data['sugarintensity'],
        ));
      });
      print("Length of the list is ${crewlist.length}");
      
    });
    return crewlist;
  }

  Future<String> fetchCrewIdFromAuthID(String authid) async {
    String crewid = "";
    await databaseReference
        .child('BrewCrewCafe/UserDetails')
        .child(authid)
        .once()
        .then((DataSnapshot snap) {
      crewid = snap.value['crewid'];
    });
    return crewid;
  }

  Future<CrewUser> addNewCrewNodes({
    String crewid,
    String authid,
    String username,
    String crewname,
  }) async {
    await databaseReference
        .child('BrewCrewCafe/CrewDetails')
        .child(crewid)
        .set({
      'admin': '$authid',
      'crewname': '$crewname',
    });
    await databaseReference
        .child('BrewCrewCafe/Crews')
        .child(crewid)
        .child(authid)
        .set({
      'authid': '$authid',
      'crewname': '$crewname',
      'name': '$username',
      'bio': '',
      'coffeeintensity': 0,
      'sugarintensity': 0,
      'crewadmin': 'true',
      'crewid': '$crewid',
    });
    await databaseReference
        .child('BrewCrewCafe/UserDetails')
        .child(authid)
        .set({
      'crewadmin': 'true',
      'crewid': '$crewid',
    });

    CrewUser crewUser = CrewUser(
      authid: authid,
      bio: '',
      crewid: crewid,
      coffeeintensity: 0,
      sugarintensity: 0,
      crewadmin: 'true',
      crewname: crewname,
      name: username,
    );
    return crewUser;
  }

  Future<int> checkCrewIDExist({String crewid}) async {
    try {
      await databaseReference
          .child('BrewCrewCafe/CrewDetails')
          .child(crewid)
          .once()
          .then((DataSnapshot snap) {
        if (snap.value == null) {
          return 0;
        } else {
          return 1;
        }
      });
    } catch (error) {
      print(error);
      return 0;
    }
  }

  Future<void> addUserInCrewNodes(
    String authid,
    String crewid,
    String name,
    String crewname,
  ) async {
    await databaseReference
        .child('BrewCrewCafe/Crews')
        .child(crewid)
        .child(authid)
        .set({
      'authid': '$authid',
      'crewname': '$crewname',
      'name': '$name',
      'bio': '',
      'coffeeintensity': 0,
      'sugarintensity': 0,
      'crewadmin': 'false',
      'crewid': '$crewid',
    });

    await databaseReference
        .child('BrewCrewCafe/UserDetails')
        .child(authid)
        .set({
      'crewadmin': 'false',
      'crewid': '$crewid',
    });
  }

  Future<String> findCrewNameFromCrewID(String crewid) async {
    print('Came inside the crewid fetcher');
    String crewname = "";
    await databaseReference
        .child('BrewCrewCafe/CrewDetails')
        .child(crewid)
        .once()
        .then((DataSnapshot snap) {
      print(snap.value['crewname']);
      crewname = snap.value['crewname'];
    });
    return crewname;
  }
}

import 'package:brew_crew_cafe/models/crewuser.dart';
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
  





  List<CrewUser> get crewlist {
    return _crewlist;
  }

  // This will return the CrewMember detail of provided authID, crew
  CrewUser findByAuthID(String authID){
    return _crewlist.firstWhere((crew) => crew.authid == authID);
  }


  List<CrewUser> crewExceptCaptain(String authID){
    final List<CrewUser> mList = _crewlist;
    mList.removeWhere((test) => test.authid == authID );
    return mList;
  }



}

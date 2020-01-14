import 'package:brew_crew_cafe/models/crewuser.dart';
import 'package:flutter/material.dart';

class CrewProvider with ChangeNotifier {
  List<CrewUser> _crewlist = [
    CrewUser(
      crewID: '01',
      authID: '001',
      crewName: 'Gladiators',
      name: 'Akshay Bengani',
      sugarIntensity: 2,
      bio: 'I am a cool asshole',
      coffeeIntensity: 7,
      isAdmin: true,
    ),
    CrewUser(
      crewID: '02',
      authID: '002',
      crewName: 'Gladiators',
      name: 'Shivank Gautam',
      sugarIntensity: 3,
      bio: 'I am a cool',
      coffeeIntensity: 6,
      isAdmin: false,
    ),
    CrewUser(
      crewID: '03',
      authID: '003',
      crewName: 'Gladiators',
      name: 'Aastha Jain',
      sugarIntensity: 1,
      bio: 'I am badass',
      coffeeIntensity: 3,
      isAdmin: false,
    ),
    CrewUser(
      crewID: '04',
      authID: '004',
      crewName: 'Gladiators',
      name: 'Akshay Bengani',
      sugarIntensity: 2,
      bio: 'I am a cool asshole',
      coffeeIntensity: 7,
      isAdmin: true,
    ),
    CrewUser(
      crewID: '05',
      authID: '005',
      crewName: 'Gladiators',
      name: 'Shivank Gautam',
      sugarIntensity: 3,
      bio: 'I am a cool',
      coffeeIntensity: 6,
      isAdmin: false,
    ),
    CrewUser(
      crewID: '06',
      authID: '006',
      crewName: 'Gladiators',
      name: 'Aastha Jain',
      sugarIntensity: 1,
      bio: 'I am badass',
      coffeeIntensity: 3,
      isAdmin: false,
    ),
  ];
  
  List<CrewUser> get crewlist {
    return [..._crewlist];
  }

  // This will return the CrewMember detail of provided authID, crew
  CrewUser findByAuthID(String authID){
    return _crewlist.firstWhere((crew) => crew.authID == authID);
  }

  List<CrewUser> crewExceptCaptain(String authID){
    final List<CrewUser> mList = _crewlist;
    mList.removeWhere((test) => test.authID == authID );
    return mList;
  }


}

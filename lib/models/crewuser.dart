import 'package:flutter/material.dart';

class CrewUser {
  String authid;
  String crewname;
  String name;
  String bio;
  int coffeeintensity;
  int sugarintensity;
  String crewadmin;
  String crewid;

  CrewUser({
    @required this.authid,
    @required this.crewname,
    @required this.name,
    @required this.bio,
    @required this.coffeeintensity,
    @required this.sugarintensity,
    @required this.crewadmin,
    @required this.crewid,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['authid'] = authid;
    map['crewname'] = crewname;
    map['name'] = name;
    map['bio'] = bio;
    map['coffeeintensity'] = coffeeintensity;
    map['sugarintensity'] = sugarintensity;
    map['crewadmin'] = crewadmin;
    map['crewid'] = crewid;
    return map;
  }

  CrewUser.fromMapObject(Map<String, dynamic> map) {
    this.authid = map['authid'];
    this.crewname = map['crewname'];
    this.name = map['name'];
    this.bio = map['bio'];
    this.coffeeintensity = map['coffeeintensity'];
    this.sugarintensity = map['sugarintensity'];
    this.crewadmin = map['crewadmin'];
    this.crewid = map['crewid'];
  }
}

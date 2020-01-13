import 'package:flutter/material.dart';

class CrewUser {
  final String crewID;
  final String authID;
  final String name;
  final String bio;
  final String crewName;
  final int coffeeIntensity;
  final int sugarIntensity;
  final bool isAdmin;

  CrewUser({
    @required this.crewID,
    @required this.authID,
    @required this.name,
    @required this.bio,
    @required this.crewName,
    @required this.coffeeIntensity,
    @required this.sugarIntensity,
    @required this.isAdmin,
  });
}

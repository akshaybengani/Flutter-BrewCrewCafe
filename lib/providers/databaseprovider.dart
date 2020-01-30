import 'dart:async';
import 'dart:io';
import 'dart:js';
import 'package:brew_crew_cafe/layouts/custominfodialog.dart';
import 'package:brew_crew_cafe/layouts/errormsgmaker.dart';
import 'package:brew_crew_cafe/models/crewuser.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider with ChangeNotifier {
  Database _database;
  static const String TABLENAME = "crewdetail";

  static const String COLAUTHID = "authid";
  static const String COLCNAME = "crewname";
  static const String COLNAME = "name";
  static const String COLBIO = "bio";
  static const String COLCOIN = "coffeeintensity";
  static const String COLSUIN = "sugarintensity";
  static const String COLCADMIN = "crewadmin";
  static const String COLCID = "crewid";

  Future<Database> get database async {
    print('Checking Database Exists or not');
    if (_database == null) {
      print("Database object found null");
      _database = await initializeDatabase();
    }
    print('Creating a table if its not existing in database');
    _database.execute(
        "CREATE TABLE IF NOT EXISTS $TABLENAME($COLAUTHID TEXT PRIMARY KEY, $COLCNAME TEXT,$COLNAME TEXT, $COLBIO TEXT, $COLCOIN INTEGER, $COLSUIN INTEGER, $COLCADMIN TEXT, $COLCID TEXT)");

    return _database;
  }

  Future<Database> initializeDatabase() async {
    print('Came to initialize Database');
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'brewcrew.db';
    print('Got the database directory in system :$path');
    var database = openDatabase(path, version: 1, onCreate: _createDB);

    return database;
  }

  void _createDB(Database db, int newVersion) async {
    print('I am here to create a new table');
    await db.execute(
        "CREATE TABLE $TABLENAME($COLAUTHID TEXT PRIMARY KEY, $COLCNAME TEXT,$COLNAME TEXT, $COLBIO TEXT, $COLCOIN INTEGER, $COLSUIN INTEGER, $COLCADMIN TEXT, $COLCID TEXT)");
  }

  Future<List<CrewUser>> getCrewList() async {
    Database db = await this.database;
    List<Map<String, dynamic>> mapList =
        await db.rawQuery('SELECT * FROM $TABLENAME');
    List<Map<String, dynamic>> x =
        await db.query('SELECT COUNT (*) FROM $TABLENAME');
    int count = Sqflite.firstIntValue(x);
    List<CrewUser> list = List<CrewUser>();
    for (int i = 0; i < count; i++) {
      list.add(CrewUser.fromMapObject(mapList[i]));
    }
    return list;
  }

  Future<CrewUser> getCurrentCrewUser(String uid) async {
    Database db = await this.database;
    List<Map<String, dynamic>> mapList =
        await db.rawQuery('SELECT * FROM $TABLENAME WHERE authid = $uid');
    List<CrewUser> list = List<CrewUser>();
    list.add(CrewUser.fromMapObject(mapList[0]));
    CrewUser crewUser = list[0];
    return crewUser;
  }

  Future<String> getCrewName(String uid) async {
    Database db = await this.database;
    List<Map<String, dynamic>> mapList =
        await db.rawQuery('SELECT * FROM $TABLENAME WHERE authid = $uid');
    List<CrewUser> list = List<CrewUser>();
    list.add(CrewUser.fromMapObject(mapList[0]));
    CrewUser crewUser = list[0];
    String crewname = crewUser.crewname;
    return crewname;
  }

  Future<String> getCurrentUserIsAdmin(String uid) async {
    Database db = await this.database;
    List<Map<String, dynamic>> mapList =
        await db.rawQuery('SELECT * FROM $TABLENAME WHERE authid = $uid');
    List<CrewUser> list = List<CrewUser>();
    list.add(CrewUser.fromMapObject(mapList[0]));
    CrewUser crewUser = list[0];
    String crewadmin = crewUser.crewadmin;
    return crewadmin;
  }

  Future<int> insertCrewMembers(List<CrewUser> crewList) async {
    Database db = await this.database;
    int total = 0;
    for (int i = 0; i < crewList.length; i++) {
      total = total + await db.insert(TABLENAME, crewList[i].toMap());
    }
    int val;
    total == crewList.length ? val = 1 : val = 0;
    return val;
  }

  Future<String> deleteTable() async {
    try {
      print('Getting dataase instance to delete');
      Database db = await this.database;
      print('Got Database Instance to delete now processing to delete table');
      await db.execute('DROP TABLE $TABLENAME');
      return "All Ok";
    } catch (error) {
      print(error.toString());
      return "Local Database Error";
    }
  }
}

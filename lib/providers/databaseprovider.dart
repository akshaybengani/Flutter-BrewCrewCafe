import 'dart:async';
import 'dart:io';
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
    print('New table created');
    return _database;
  }

  Future<Database> initializeDatabase() async {
    print("Came to initialize Database");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'brewcrewcafe.db';
    print('Got the database directory in system :$path');
    var database = openDatabase(path, version: 1, onCreate: _createDB);
    print('Database Opened or used alreaady one');
    return database;
  }

  void _createDB(Database db, int newVersion) async {
    print('I am here to create a new table');
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $TABLENAME($COLAUTHID TEXT PRIMARY KEY, $COLCNAME TEXT,$COLNAME TEXT, $COLBIO TEXT, $COLCOIN INTEGER, $COLSUIN INTEGER, $COLCADMIN TEXT, $COLCID TEXT)");
    print('I just created a table in _createDB function');
  }

  Future<List<CrewUser>> getCrewList() async {
    print('I am here to get CrewList');
    Database db = await this.database;
    print('I am going to fetch all the values from the database');
    
    List<Map<String, dynamic>> mapList = await db.query(TABLENAME);

    //List<Map<String, dynamic>> mapList =
    //    await db.rawQuery("SELECT (*) FROM $TABLENAME");
    //print('I just fetched all the values from Database and now going to count');
    //List<Map<String, dynamic>> x =
    //    await db.rawQuery("SELECT COUNT (*) FROM $TABLENAME");
    //print('I am going to run a query to collect number of rows its called as Sqflite.firstIntValue ');
    //int count = Sqflite.firstIntValue(x);
    int count = mapList.length;
    print("I just counted all the rows :$count");
    List<CrewUser> list = List<CrewUser>();
    print('Its time to insert the values so get ready');
    for (int i = 0; i < count; i++) {
      print('I just inserted $i value in the list');
      list.add(CrewUser.fromMapObject(mapList[i]));
    }
    print('Now I am going to return the list');
    return list;
  }

  Future<CrewUser> getCurrentCrewUser(String uid) async {
    print('Cool I am here to get the current crew user');
    Database db = await this.database;
    print('Got connected with the database');
    print("I am going to fetch the data values where authid is the condition");
    List<Map<String, dynamic>> mapList =
        await db.rawQuery("SELECT (*) FROM $TABLENAME WHERE authid = $uid");
    print('I fetched all the data and saved in a list of map which is a string dynamic map');
    List<CrewUser> list = List<CrewUser>();
    print('I am going to add the 1st value from the crewuser list');
    list.add(CrewUser.fromMapObject(mapList[0]));
    print('The 1st value is inserted in the crewuser object');
    CrewUser crewUser = list[0];
    print('Its time to return the crewuser');
    return crewUser;
  }

  Future<String> getCrewName(String uid) async {
    print('I am here to get the crewname from the database');
    Database db = await this.database;
    print('Its time to fetch crewdata of the authid based user');
    List<Map<String, dynamic>> mapList =
        await db.rawQuery("SELECT (*) FROM $TABLENAME WHERE authid = $uid");
    print('Now I am creating an empty crewlist for storage');
    List<CrewUser> list = List<CrewUser>();
    print('I am going to add the maplist objects in the maplist system');
    list.add(CrewUser.fromMapObject(mapList[0]));
    print('1st value of map is added');
    CrewUser crewUser = list[0];
    print('Extracted the crewname from the crewlist');
    String crewname = crewUser.crewname;
    print('I have returned the crewname');
    return crewname;
  }

  Future<String> getCurrentUserIsAdmin(String uid) async {
    Database db = await this.database;
    List<Map<String, dynamic>> mapList =
        await db.rawQuery("SELECT (*) FROM $TABLENAME WHERE authid = $uid");
    List<CrewUser> list = List<CrewUser>();
    list.add(CrewUser.fromMapObject(mapList[0]));
    CrewUser crewUser = list[0];
    String crewadmin = crewUser.crewadmin;
    return crewadmin;
  }

  Future<int> insertCrewMembers(List<CrewUser> crewList) async {
    print('I am here to insert crew members in the database');
    Database db = await this.database;
    print('Database instantiation complete');
    int total = 0;
    for (int i = 0; i < crewList.length; i++) {
      print('Now I am adding rows in the table current index is :$i');
      total = total + await db.insert(TABLENAME, crewList[i].toMap());
    }
    total--;
    int val;
    total == crewList.length ? val = 1 : val = 0;
    print("Value of val inside insertCrewMembers is $val");
    print("Value of total we get is $total and the value of crewlist.length is ${crewList.length}");
    print('Returned the check value 1 or 0 which will be used to judge add inserted successfully or something left');
    return 1;
  }

  Future<String> deleteTable() async {
    try {
      print('Getting dataase instance to delete');
      Database db = await this.database;
      print('Got Database Instance to delete now processing to delete table');
      await db.execute("DROP TABLE IF EXISTS $TABLENAME");
      return "All Ok";
    } catch (error) {
      print(error.toString());
      return "Local Database Error";
    }
  }

  Future<void> deleteRows() async {
    print('I am here to delete the database rows records');
    Database db = await this.database;
    print('Database Setuped');
    await db.rawQuery('DELETE FROM $TABLENAME');
    print('Deleted All the records');


  }

  Future<void> updateUserPref(CrewUser crewUser) async {
    print('I am here to update the user pref in table');
    Database db = await this.database;
    print('Database setup complete now going to run the update queries');
    await db.rawUpdate("UPDATE $TABLENAME SET $COLBIO = '${crewUser.bio}' WHERE $COLAUTHID = '${crewUser.authid}'");
    await db.rawUpdate("UPDATE $TABLENAME SET $COLCOIN = ${crewUser.coffeeintensity} WHERE $COLAUTHID = '${crewUser.authid}'");
    await db.rawUpdate("UPDATE $TABLENAME SET $COLSUIN = '${crewUser.sugarintensity}' WHERE $COLAUTHID = '${crewUser.authid}'");
    print('Update work completde');
  }

}

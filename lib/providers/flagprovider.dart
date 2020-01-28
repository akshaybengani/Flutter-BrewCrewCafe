import 'package:flutter/material.dart';

class FlagProvider with ChangeNotifier{
  // This was set to true because when authentication is already done And we need 
  // To fetch from local then we will get null because signinscreen never reached
  bool _dataExist = true;

  void get dataExistTrue{
    this._dataExist = true;
  }

  bool get dataExistStatus{
    return this._dataExist;
  }

  void get dataExistFalse{
    this._dataExist = false;
  }


}
import 'package:flutter/material.dart';

class UserManageTile extends StatelessWidget {
  final String name, authID;
  UserManageTile({@required this.name, @required this.authID});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.brown[800]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        // contentPadding: EdgeInsets.all(10),
        title: Text(name, style: TextStyle(fontSize: 20),),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.brown[800], ),
          onPressed: () {},
        ),
      ),
    );
  }
}

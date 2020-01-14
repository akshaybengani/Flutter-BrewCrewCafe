import 'package:flutter/material.dart';

class UserManageTile extends StatelessWidget {
  final String name, authID;
  UserManageTile({@required this.name, @required this.authID});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.brown[800], width: 3),
      ),
      child: ListTile(
        // contentPadding: EdgeInsets.all(10),
        title: Text(name, style: TextStyle(fontSize: 20),),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.brown[500],),
          onPressed: () {},
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CrewPrefTile extends StatelessWidget {
  final String name, bio;
  final int coffeeIntensity, sugarIntensity;

  CrewPrefTile(
      {this.name, this.bio, this.coffeeIntensity, this.sugarIntensity});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.brown[coffeeIntensity * 100]),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.brown[coffeeIntensity * 100],
          child: Text(
            '${coffeeIntensity * 10}%',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(name),
        subtitle: Text('Takes $sugarIntensity spoon\'s sugar'),
        trailing: IconButton(
          icon: Icon(
            Icons.info,
            color: Colors.brown[coffeeIntensity * 100],
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(
                  name,
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.brown[coffeeIntensity * 100]),
                ),
                content: SizedBox(
                  height: 200,
                  child: Column(
                    children: <Widget>[
                      Expanded(child: Text(bio)),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    Colors.brown[coffeeIntensity * 100],
                                child: Text(
                                  '${coffeeIntensity * 10}%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Coffee'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    Colors.amber[sugarIntensity * 100],
                                child: Text(
                                  '${sugarIntensity * 10}%',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Sugar'),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.only(bottom: 20, right: 20),
                    child: Text(
                      'Brew It',
                      style:
                          TextStyle(color: Colors.brown[coffeeIntensity * 100], fontSize: 20),
                    ),
                    onPressed: Navigator.of(context).pop,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

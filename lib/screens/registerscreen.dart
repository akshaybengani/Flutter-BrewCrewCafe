import 'package:brew_crew_cafe/screens/coffeeprefscreen.dart';
import 'package:brew_crew_cafe/screens/signinscreen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const routename = '/registerscreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool newTeamToggle = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: theme.primaryTextTheme.subhead,
                  children: <TextSpan>[
                    const TextSpan(text: 'Welcome to\n'),
                    TextSpan(
                      text: 'Brew Crew\n',
                      style: theme.primaryTextTheme.headline,
                    ),
                    const TextSpan(text: 'Cafe'),
                  ],
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: theme.primaryColor),
                ),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Text('Register New User',
                          style: theme.primaryTextTheme.body1),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.person), labelText: 'Name'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.email), labelText: 'Email'),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock), labelText: 'Password'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              !newTeamToggle
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: theme.primaryColor),
                      ),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Text('Crew Details',
                                style: theme.primaryTextTheme.body1),

                            // ...

                            const SizedBox(height: 20),
                            const Text(
                                'Enter Your Crew ID received from your \nCrew or Captain'),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    onTap: () {},
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.group),
                                        labelText: 'Crew ID'),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.content_paste),
                                  onPressed: () {},
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  newTeamToggle = !newTeamToggle;
                                });
                              },
                              child: const Text('Create a New Brew Crew Team'),
                            )

                            // ...
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: theme.primaryColor),
                      ),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Text('New Crew Details',
                                style: theme.primaryTextTheme.body1),

                            // ...

                            const SizedBox(height: 20),
                            const Text(
                                'To create your own brew crew team,\nEnter your Crew team name'),
                            TextFormField(
                              onTap: () {},
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.group),
                                  labelText: 'Unique Crew Name'),
                            ),

                            const SizedBox(height: 20),
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  newTeamToggle = !newTeamToggle;
                                });
                              },
                              child: const Text('Join your existing Crew'),
                            )

                            // ...
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      child: const Text('LOGIN'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignInScreen.routename);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      child: const Text('REGISTER'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(CoffeePrefScreen.routename);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

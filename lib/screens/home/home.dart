import 'package:brew_coffee/models/brew.dart';
import 'package:brew_coffee/screens/home/brew_list.dart';
import 'package:brew_coffee/screens/home/settings_form.dart';
import 'package:brew_coffee/services/auth.dart';
import 'package:brew_coffee/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              color: Colors.white,
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: _showSettingsPanel,
            ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('Logout'),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}

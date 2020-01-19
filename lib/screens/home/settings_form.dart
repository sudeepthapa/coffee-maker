import 'package:brew_coffee/models/user.dart';
import 'package:brew_coffee/services/database.dart';
import 'package:brew_coffee/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_coffee/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  String _currentName;
  String _currentSugar;
  int _currentStrength;
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot.hasData);
        if (snapshot.hasData && !loading) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Text(
                  "Update your brew settings.",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  onChanged: (value) {
                    setState(() {
                      _currentName = value;
                    });
                  },
                  validator: (val) =>
                      val.isEmpty ? "Please enter a name." : null,
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val.isEmpty ? "Please select sugar." : null,
                  value: _currentSugar ?? userData.sugars,
                  onChanged: (val) {
                    setState(() {
                      _currentSugar = val;
                    });
                  },
                  items: sugars
                      .map((String sugar) => DropdownMenuItem(
                            value: sugar,
                            child: Text(sugar + ' sugars'),
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                Slider(
                  min: 0,
                  max: 900,
                  value: _currentStrength != null
                      ? _currentStrength.toDouble()
                      : userData.strength,
                  divisions: 9,
                  label: _currentStrength.toString(),
                  activeColor: Colors.brown[_currentStrength ?? 100],
                  inactiveColor: Colors.brown[_currentStrength ?? 100],
                  onChanged: (val) {
                    setState(() {
                      _currentStrength = val.toInt();
                    });
                  },
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    print(_currentName);
                    print(_currentStrength);
                    print(_currentSugar);
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await DatabaseService(uid: user.uid)
                          .updateUserData(
                              _currentSugar ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                      if (result != null) {
                        Navigator.pop(context);
                      }
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = "Error Updating";
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14))
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

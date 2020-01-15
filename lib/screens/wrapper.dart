import 'package:brew_coffee/screens/authentication/authenticate.dart';
import 'package:brew_coffee/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return either home or authenticate widget
    return Home();
  }
}

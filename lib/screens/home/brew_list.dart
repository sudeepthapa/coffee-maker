import 'package:brew_coffee/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_coffee/models/brew.dart';

class BrewList extends StatefulWidget {
  BrewList({Key key}) : super(key: key);

  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    return ListView.builder(
      itemCount: brews != null ? brews.length : 0,
      itemBuilder: (context, int index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}

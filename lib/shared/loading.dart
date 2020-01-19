import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitCubeGrid(
        color: Colors.brown[100],
        size: 50.0,
      ),
    );
  }
}

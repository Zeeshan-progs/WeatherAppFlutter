import 'package:flutter/material.dart';

import 'Content/Appbar.dart';
import 'Content/Body.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: appBar,
        body: BodyWidget(),
      ),
    );
  }
}

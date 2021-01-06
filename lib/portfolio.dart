import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';

class portfolioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<portfolioPage> {
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Portfolio', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
	  )
    );
  }
}  
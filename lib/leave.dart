import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';

class leavePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<leavePage> {
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Leave Applications', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            forLeave(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => editLeavePage()),  
          );  
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget forLeave(){
    return Column(children: <Widget>[
    ]);
  }
}

class editLeavePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new leaveState();
}
class leaveState extends State<editLeavePage> {
  FocusNode myFocusNode = new FocusNode();
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Leave Applications', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Leave Start',
                labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.red : Colors.black, fontSize: 14)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Leave End',
                labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.red : Colors.black, fontSize: 14)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Leave Reason',
                labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.red : Colors.black, fontSize: 18)
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0,right: 230.0),
            child: RaisedButton(
              color: Colors.blue, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), 
              child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 18)),
              onPressed: () => {},
            ),  
          ),  
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => leavePage()),  
          );  
        },
        child: Icon(Icons.cancel),
        backgroundColor: Colors.red,
      ),
    );
  }
}    
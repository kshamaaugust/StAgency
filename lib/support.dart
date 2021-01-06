import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class supportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<supportPage> {
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      appBar: AppBar(
        title: Text('Support Tickets', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => _editsupport()),  
          );  
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
class _editsupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfileState();
}
class _ProfileState extends State<_editsupport>{ 
  FocusNode myFocusNode = new FocusNode();
  var token, id, jsonData;
  final storage = new FlutterSecureStorage();
  TextEditingController subController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  
  Upload(String sub,String msg) async {
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    id = (jsonLogin['id'].toString());

    Map data = { 
      'user': id,
      'subject':subController.text,
      'message':msgController.text,
      'source': 'Android',
      'status':'Inactive'
    };
    jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/support/", body: data, headers: <String, String>{'authorization':"Token " +token});
    jsonData = json.decode(response.body);
    if(response.statusCode == 201){
      AlertDialog alert = AlertDialog(  
        title: new Text('Simple Alert'),  
        content: new Text('Your data has been submitted successfully.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.push(  
                this.context,  
                MaterialPageRoute(builder:(context) => supportPage()),  
              );
            },
            color: Colors.blue,
            child: const Text('Okay'),
          ),
        ],    
      ); 
      showDialog(  
        context: context,  
        builder: (BuildContext context) {  
          return alert;  
        },  
      );
    }
    setState((){ token; jsonData; id; });
  }
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Tickets', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: TextField(
                controller: subController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Subject',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: msgController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Message',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 220.0),
              child: RaisedButton(
                color: Colors.blue, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 18),),
                onPressed: () => Upload(subController.text, msgController.text),
              ),  
            ),  
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => supportPage()),  
          );  
        },
        child: Icon(Icons.cancel),
        backgroundColor: Colors.red,
      ),
    );
  } 
}
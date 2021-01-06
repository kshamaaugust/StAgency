import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<ContactPage> {
  FocusNode myFocusNode = new FocusNode();
  var token, id, mail, fn, ln, mob, name, jsonData;
  final storage = new FlutterSecureStorage();
  TextEditingController subController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  
  Upload(String sub,String msg) async {
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    id = (jsonLogin['id'].toString());
    mail = jsonLogin['email'];
    fn = jsonLogin['first_name'];
    ln = jsonLogin['last_name'];
    mob = jsonLogin['mobile'].toString();
    name  = fn+" "+ln;

    Map data = { 
      'user': id,
      'name': name,
      'mobile': mob,
      'subject':subController.text,
      'message':msgController.text,
      'email': mail,
      'source': 'Android',
      'status':'Inactive'
    };
    jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/contact/", body: data, headers: <String, String>{'authorization':"Token " +token});
    jsonData = json.decode(response.body);
    if(response.statusCode == 201){
      AlertDialog alert = AlertDialog(  
        title: new Text('Simple Alert'),  
        content: new Text('Your data has been submitted successfully.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(this.context).pop();
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
    setState((){ token; jsonData; name; mail; id; mob; });
  }
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Contact Us', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0)),
            Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 35, 0, 0),
                child: new Text('Name :- ', style: TextStyle(fontSize: 16),),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 35, 0, 0),
                child: new Text(name.toString() ?? 'default', style: TextStyle(fontSize: 16),),
              ),
            ]),
            Container(padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0)),
            new Divider(color: Colors.black),
            Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                child: new Text('Mobile :- ', style: TextStyle(fontSize: 16),),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                child: new Text(mob.toString() ?? 'default', style: TextStyle(fontSize: 16),),
              ),
            ]),
            Container(padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0)),
            new Divider(color: Colors.black),
            Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                child: new Text('Email :- ', style: TextStyle(fontSize: 16),),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                child: new Text(mail.toString() ?? 'default', style: TextStyle(fontSize: 16),),
              ),
            ]),
            Container(padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 05.0)),
            new Divider(color: Colors.black),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                controller: subController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                  hintText: 'Subject',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: msgController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
                  hintText: 'Message',
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
    );
  }
}  
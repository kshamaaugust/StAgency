import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'professional.dart';
import 'leave.dart';

class homePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<homePage> {
  var token, leaves, prof;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{   
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token']; 
    var jsondata = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/home/", headers: <String, String>{'authorization':"Token " +token});
    jsondata = json.decode(response.body);
    prof = jsondata['professionals'];
    leaves = jsondata['leaves'];
    setState(() { token; prof; leaves; });
  }
  @override  
  Widget build(BuildContext context) {  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Row(children: [
            Container(
              padding: EdgeInsets.fromLTRB(20,20,0,0),
              height: 140, width: 160,
              child: Card(
                color: Colors.blue,
                child: InkWell(
                  onTap: () => Navigator.push(  
                    context,  
                    MaterialPageRoute(builder: (context) => professionalPage()),  
                  ),
                  child: Column(children: <Widget>[
                    Row(children: [
                      IconButton(icon: Icon(Icons.person, color: Colors.white)),
                      Container(
                        child: Center(child: Text(prof.toString() ?? 'default', style: TextStyle(color: Colors.white, fontSize: 18))),
                      ),
                    ]),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,20,0,20),
                        child: Text('Professional', style: TextStyle(color: Colors.white, fontSize: 15),),
                      ),
                    ]),
                  ]),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20,20,0,0),
              height: 140, width: 160,
              child: Card(
                color: Colors.red,
                child: InkWell(
                  onTap: () => Navigator.push(  
                    context,  
                    MaterialPageRoute(builder: (context) => leavePage()),  
                  ),
                  child: Column(children: <Widget>[
                    Row(children: [
                      IconButton(icon: Icon(Icons.person, color: Colors.white)),
                      Container(
                        child: Center(child: Text(leaves.toString() ?? 'default', style: TextStyle(color: Colors.white, fontSize: 18))),
                      ),
                    ]),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,20,0,20),
                        child: Text('Leaves', style: TextStyle(color: Colors.white, fontSize: 15),),
                      ),
                    ]),
                  ]),
                ),
              ),
            ),
          ]),
          Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(20,20,0,0),
              height: 150,
              child: Card(
                child: Column(children: <Widget>[
                  Row(children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0,15,170,0),
                      child: Center(child: Text('Active Duties', style: TextStyle(color: Colors.black, fontSize: 20))),
                    ),
                  ]),
                  Column(children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10,20,40,0),
                      child: Text('Check All yours all Work Diaries and Track associated Professionals.', overflow: TextOverflow.ellipsis, maxLines: 2,style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                  ]),                    
                ]),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
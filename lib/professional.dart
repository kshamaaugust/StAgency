import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_formfield/dropdown_formfield.dart'; 
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class professionalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<professionalPage> {
  var id, token, jsonData, total;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getData();
  } 
  Future<void> getData() async{   
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    id = (jsonLogin['id'].toString());

    jsonData = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/users/?service=Professional&parent="+id, headers: <String, String>{'authorization': 'Token ' +token});    
    print(response.statusCode);
    jsonData = json.decode(response.body);
    print(jsonData);
    total = jsonData['count'];

    setState(() { token; });
  }
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Professionals', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,   
          children: [   
            viewProf(),
          ], 
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => editProfPage()),  
          );  
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget viewProf(){
    return Container(
      padding: EdgeInsets.fromLTRB(20,15,20,0),
      height: 560.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: total,
        itemBuilder: (BuildContext context, int i) =>
        Card(
          child: Container(
            width: 190.0,
            child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),),
              Text(jsonData['results'][i]['username'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 22),),
              Padding(padding: EdgeInsets.fromLTRB(0,20,0,0),),
              Text(jsonData['results'][i]['mobile'].toString() ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
              Padding(padding: EdgeInsets.fromLTRB(0,30,0,0),),
              FlatButton(
                color: Colors.blue, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)),
                child: Text("View", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(  
                    context,  
                    MaterialPageRoute(builder: (context) => editProfPage()),  
                  );  
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class editProfPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new editState();
}
class editState extends State<editProfPage> {
  @override 
  var id;
  String myActivity;
  String myActivityResult;
  Position currentPosition;
  FocusNode myFocusNode = new FocusNode();
  final formKey = new GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

  TextEditingController fnController     = TextEditingController();
  TextEditingController lnController     = TextEditingController();
  TextEditingController unController     = TextEditingController();
  TextEditingController mobController    = TextEditingController();
  TextEditingController mailController   = TextEditingController();
  TextEditingController pasController    = TextEditingController();
  TextEditingController cnpasController  = TextEditingController();

  Upload(String agency,String fn,String ln,String un,String mob,String mail,String pas,String cpas) async {
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    id = (jsonLogin['id'].toString());
    Map data = { 
      'profession': myActivityResult,
      'first_name': fnController.text,
      'last_name':  lnController.text,
      'username':   unController.text,
      'mobile':     mobController.text,
      'email':      mailController.text,
      'password':   pasController.text,
      'cpassword':  cnpasController.text,
      'company':    '',
      "referedby":  '',
      "parent":     id,
      "latitude":   currentPosition.latitude.toString(),
      "longitude":  currentPosition.longitude.toString(),
      'service':    'Professional',
    };

    var jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/signup/", body: data);
    if(pasController.text != cnpasController.text){
      AlertDialog alert1 = AlertDialog(  
        title: new Text("Simple Alert"),  
        content: new Text("Passwords are not same", style: TextStyle(color: Colors.red),),    
      ); 
      showDialog(  
        context: context,  
        builder: (BuildContext context) {  
          return alert1;  
        },  
      );       
    }
    else if(response.statusCode == 400){
      AlertDialog alert3 = AlertDialog(  
        title: new Text("Simple Alert"),  
        content: new Text("Already exist username and mobile", style: TextStyle(color: Colors.red),),    
      ); 
      showDialog(  
        context: context,  
        builder: (BuildContext context) {  
          return alert3;  
        },  
      );
    }
    else{
      AlertDialog alert = AlertDialog(  
        title: new Text("Simple Alert"),  
        content: new Text("Data has submitted successfully"), 
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.push(  
                this.context,  
                MaterialPageRoute(builder:(context) => professionalPage()),  
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
  }

  @override  
  void initState() {
    super.initState();
    myActivity = '';
    myActivityResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    setState(() {
      myActivityResult = myActivity;
      print(myActivityResult);
    });
  }
  Widget build(BuildContext context) {  
    return new Scaffold(
      appBar: AppBar(
        title: Text('Professional', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container( 
              child: Form(
                key: formKey,
                child: Column(
                  key: formKey,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16), 
                      child: DropDownFormField(
                        titleText: 'Professional',
                        hintText: 'Select Type',
                        value: myActivity,
                        onSaved: (value) {
                          setState(() {
                            myActivity = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            myActivity = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Select Type",
                            "value": "Select Type",
                          },
                          {
                            "display": "Watchman",
                            "value": "Watchman",
                          },
                          {
                            "display": "Gunman",
                            "value": "Gunman",
                          },
                          {
                            "display": "Valet",
                            "value": "Valet",
                          },
                          {
                            "display": "Bouncer",
                            "value": "Bouncer",
                          },
                          {
                            "display": "Bodyguard",
                            "value": "Bodyguard",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: fnController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  labelText: 'First Name',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: lnController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  labelText: 'Last Name',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: unController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: mobController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  labelText: 'Mobile',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: mailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: pasController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                controller: cnpasController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  labelText: 'Confirm',
                  labelStyle: TextStyle(
                    color: myFocusNode.hasFocus ? Colors.red : Colors.black
                  )
                ),
              ),
            ),
            Row(children: [
              Container(
                margin: const EdgeInsets.only(left: 40.0, right: 0.0, top: 10,),
                child: new Text( "LAT: "),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5.0, right: 0.0, top: 10,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (currentPosition != null)
                      Text("${currentPosition.latitude}"),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50.0, right: 0.0, top: 10,),
                child: new Text( "LNG: "),
              ),
              Container(
                margin: const EdgeInsets.only(left: 05.0, right: 0.0, top: 10,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (currentPosition != null)
                      Text("${currentPosition.longitude}"),
                  ],
                ),
              ),
            ]),
            Row(children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0, top: 20,),
                child: RaisedButton(
                  color: Colors.blue, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text('LOCATION',style: TextStyle(color: Colors.white,fontSize: 16),),
                  onPressed: () {
                    _getCurrentLocation();
                  },
                ),  
              ),
              Container(
                margin: const EdgeInsets.only(left: 0.0, right: 10.0, top: 20,),
                child: RaisedButton(
                  color: Colors.blue, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 16),),
                  onPressed: () => Upload(myActivityResult, fnController.text, lnController.text, unController.text, mobController.text, mailController.text, pasController.text,cnpasController.text),
                ),  
              ),
            ]), 
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => professionalPage()),  
          );  
        },
        child: Icon(Icons.cancel),
        backgroundColor: Colors.red,
      ),
    );
  }
  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
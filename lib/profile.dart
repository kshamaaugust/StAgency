import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class profilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<profilePage>{
  FocusNode myFocusNode = new FocusNode();
  var token, id;
  var jsondata;
  var image, agency, fn, ln, un, mail, mb, phn, registr, address, local, city, state, zip, tag, about, web, fb, twit, insta;
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
    id = (jsonLogin['id'].toString());
    jsondata = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/users/"+id+"/", headers: <String, String>{'authorization':"Token " +token});
    jsondata = json.decode(response.body);

    image = (jsondata['image']);
    // agncy = (jsondata['agency']);
    fn = (jsondata['first_name']);
    ln = (jsondata['last_name']);
    un = (jsondata['username']);
    mail = (jsondata['email']);
    mb = (jsondata['mobile']);
    phn = (jsondata['phone']);
    address = (jsondata['address']);
    local = (jsondata['locality']);
    city = (jsondata['city']);
    zip = (jsondata['zipcode']);
    tag = (jsondata['tagline']);
    about = (jsondata['about']);
    web = (jsondata['website']);
    fb = (jsondata['facebook']);
    twit = (jsondata['twitter']);
    insta = (jsondata['instagram']);
    await storage.write(key: 'image', value: image);
    setState(() { token; });
  }
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            _editTitleTextField()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => _editProfile()),  
          );  
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget _editTitleTextField(){
    return Column(children: <Widget>[
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(70, 20, 0, 0),
          width: 280, height: 200,
          child: new CircleAvatar(
            backgroundImage: new NetworkImage(image.toString() ?? 'default'),
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Agency :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text("  ", style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('First Name :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(fn.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Last Name :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(ln.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Username :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(un.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Email :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(mail.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Mobile :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(mb.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Phone :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(phn.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Registration :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text("  ", style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Address :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(address.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Locality :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(local.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('City :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(city.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('State :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text("   ", style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Zip code :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(zip.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Tagline :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(tag.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('About :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(about.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Website :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(web.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Facebook :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(fb.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Twitter :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(twit.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Instagram :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(insta.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      ),
      new Divider(color: Colors.black),
    ]);
  }
}
class _editProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfileState();
}
class _ProfileState extends State<_editProfile>{ 
  FocusNode myFocusNode = new FocusNode();
  var token, id;
  final storage = new FlutterSecureStorage();
  File _image;
  Position _currentPosition;

  // TextEditingController agencyController  = TextEditingController();
  TextEditingController fnController      = TextEditingController();
  TextEditingController lnController      = TextEditingController();
  TextEditingController unController      = TextEditingController();
  TextEditingController mailController    = TextEditingController();
  TextEditingController mnoController     = TextEditingController();
  TextEditingController pnoController     = TextEditingController();
  // TextEditingController regisController   = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController localController   = TextEditingController();
  TextEditingController cityController    = TextEditingController();
  // TextEditingController stateController   = TextEditingController();
  TextEditingController zipController     = TextEditingController();
  TextEditingController tagController     = TextEditingController();
  TextEditingController aboutController   = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController facebookController= TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instaController   = TextEditingController();
  TextEditingController langController    = TextEditingController();
  TextEditingController longController    = TextEditingController();

  @override

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 50
    );
    setState(() {
      _image = image;
    });
  }
  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50
    );
    setState(() {
      _image = image;
    });
  }
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  title: new Text('Profile'),
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.cancel),
                  title: new Text('Cancel'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  } 

  Upload(String fn, String ln, String un, String mail, String mob, String phn,  String address,String lacality, String city, String zipcode, String tagline, String about, String website, String facebook, String twitter,  String instagram, String lang, String long, File imageFile) async {    
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    id = (jsonLogin['id'].toString());

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://139.59.66.2:9000/stapi/v1/users/"+id+"/");
    Map<String, String> headers = { "authorization": "Token " +token};
    var request = new http.MultipartRequest("patch", uri);

    request.headers.addAll(headers);
    request.fields['user'] = id;
    // request.fields['agency']       = agencyController.text;
    request.fields['first_name']   = fnController.text;
    request.fields['last_name']    = lnController.text;
    request.fields['username']     = unController.text;
    request.fields['email']        = mailController.text;
    request.fields['mobile']       = mnoController.text;
    request.fields['phone']        = pnoController.text;
    // request.fields['registration'] = regisController.text;
    request.fields['address']      = addressController.text;
    request.fields['locality']     = localController.text;
    request.fields['city']         = cityController.text;
    // request.fields['state']        = stateController.text;
    request.fields['zipcode']      = zipController.text;
    request.fields['tagline']      = tagController.text;
    request.fields['about']        = aboutController.text;
    request.fields['website']      = websiteController.text;
    request.fields['facebook']     = facebookController.text;
    request.fields['twitter']      = twitterController.text;
    request.fields['instagram']    = instaController.text;
    request.fields['latitude']     = langController.text;
    request.fields['longitude']    = longController.text;

    var multipartFile = new http.MultipartFile('image', stream, length,
      filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    if(response.statusCode == 200){
      AlertDialog alert = AlertDialog(  
        title: new Text('Simple Alert'),  
        content: new Text('Your data has been submitted successfully.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.push(  
                this.context,  
                MaterialPageRoute(builder:(context) => profilePage()),  
              );
            },
            color: Colors.blue,
            child: const Text('Okay'),
          ),
        ],    
      ); 
      showDialog(  
        context: this.context,  
        builder: (BuildContext context) {  
          return alert;  
        },  
      );
    }
    setState((){ token; });
  }
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new Center(
        child: ListView(children: <Widget>[
          SizedBox(height: 32),
          Center(
            child: GestureDetector(
              onTap: () { _showPicker(this.context); },
              child: CircleAvatar(
                radius: 55,
                child: _image != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file( _image, width: 100, height: 100, fit: BoxFit.fitHeight),
                )
                : Container(
                  decoration: BoxDecoration( color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
                  width: 100, height: 100,
                  child: Icon(Icons.camera_alt,color: Colors.grey[800]),
                ),
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          //   child: TextField(
          //     // controller: agencyController,
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          //       labelText: 'Agency :-',
          //       labelStyle: TextStyle(
          //         color: myFocusNode.hasFocus ? Colors.red : Colors.black
          //       )
          //     ),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: fnController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'First Name :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: lnController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Last Name :- ',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: unController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Username :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: mailController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Email :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: mnoController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Mobile :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: pnoController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Phone :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          //   child: TextField(
          //     controller: regisController,
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          //       labelText: 'Registration :-',
          //       labelStyle: TextStyle(
          //         color: myFocusNode.hasFocus ? Colors.red : Colors.black
          //       )
          //     ),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: addressController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Address :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: localController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Locality :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: cityController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'City :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          //   child: TextField(
          //     controller: stateController,
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          //       labelText: 'State :-',
          //       labelStyle: TextStyle(
          //         color: myFocusNode.hasFocus ? Colors.red : Colors.black
          //       )
          //     ),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: zipController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Zip Code :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: tagController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Tagline :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: aboutController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'About :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: websiteController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Website :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: facebookController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Facebook :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: twitterController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Twitter :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: instaController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Instagram :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: langController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Latitude :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: longController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'longitude :-',
                labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.red : Colors.black
                )
              ),
            ),
          ),
          Row(children: [
            Container(
              padding: EdgeInsets.fromLTRB(20,0,0,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // if (_currentPosition != null)
                  //   Text(
                  //       "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
                  FlatButton(
                    color: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: Text("LOCATION",style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      _getCurrentLocation();
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right:0.0),
              child: RaisedButton(
                color: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
                child: Text('UPDATE',style: TextStyle(color: Colors.white)),
                onPressed: () => Upload(fnController.text, lnController.text, unController.text, mailController.text, mnoController.text, pnoController.text, addressController.text, localController.text, cityController.text, zipController.text, tagController.text, aboutController.text, websiteController.text, facebookController.text, twitterController.text, instaController.text, langController.text, longController.text, File(_image.path)),
              ),  
            ),
          ]),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => profilePage()),  
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
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}  
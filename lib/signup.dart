import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newproject/signin.dart';
import 'package:newproject/welcom.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController varsity = TextEditingController();
  TextEditingController mobile = TextEditingController();



  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String error = 'Error Uploading Image ';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  uploadImg() {
    if (null == tmpFile) {
      setStatus(error);
      return;
    }

    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post('https://influxdev.com/bdb/books/registraion.php', body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : error);
    }).catchError((error) {
      setStatus(error);
    });
  }
  /////////////
  /*
  Future<List> senddata() async {
    final response = await http.post('http://192.168.0.105/books/wellcomemsg.php', body: {
      "name": name.text,
    });
  }*/

  //////





  Future register() async{
    var url = "https://influxdev.com/bdb/books/registraion.php";
    var response = await http.post(url,body:{
      "name": name.text,
      "password" : password.text,
      "email" : email.text,
      "varsity" : varsity.text,
      "mobile" : mobile.text,
      
    }
    );


    var data = json.decode(response.body);
    if(data=="Login Matched"){
      Fluttertoast.showToast(
        msg: "User Already Registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
    }
    else{
      Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
    }
  }





  @override


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                /*Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                    'assets/images/logo3.jpg',
                   
                    fit: BoxFit.fitWidth

                  )
                  ),*/
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    )),

                FutureBuilder<File>(
                  future: file,
                  builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        null != snapshot.data) {
                      tmpFile = snapshot.data;
                      base64Image = base64Encode(snapshot.data.readAsBytesSync());
                      return Container(
                        margin: EdgeInsets.all(15),
                        child: Material(
                          elevation: 3.0,
                          child: Image.file(
                            snapshot.data,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    } else if (null != snapshot.error) {
                      return const Text(
                        'Error!',
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.all(15),
                        child: Material(
                          elevation: 3.0,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                child: Image.asset('assets/images/profile.png'),
                              ),
                              InkWell(
                                onTap: () {
                                  chooseImage();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10.0, right: 10.0),
                                  child: Icon(
                                    Icons.edit,
                                    size: 30.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),

                /*Container(
                  height: 50.0,
                  width: 360.0,
                  child: RaisedButton(
                    child: Text(
                      'Upload Image',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      uploadImg();
                    },
                  ),
                ),*/
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      labelText: 'User Name',

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail),
                      labelText: 'Email',
                    ),
                  ),
                ),

                 Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: varsity,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.school),
                      labelText: 'University Name',
                    ),
                  ),
                ),

             Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: mobile,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.smartphone),
                      labelText: 'Your Mobile No',
                    ),
                  ),
                ),


                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                  ),
                ),
                 SizedBox(
              height: 16.0,
            ),
                Container(
                  height: 60,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Sign Up',
                      style: TextStyle(fontSize: 23.0)
                      ),
                      onPressed: () {
                        uploadImg();
                        register();
                       // senddata;
                       Fluttertoast.showToast(
                            msg: "SignUp successful ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));

                      },
                    )),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text('Already have an account?'),
                      FlatButton(
                        textColor: Colors.blue,
                        child: Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: (
                        ) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
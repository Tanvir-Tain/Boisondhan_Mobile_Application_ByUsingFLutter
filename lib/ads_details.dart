import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newproject/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AdsDetails extends StatefulWidget {
  final ProductModel product;
  AdsDetails(this.product);

  @override
  _AdsDetailsState createState() => _AdsDetailsState();
}

class _AdsDetailsState extends State<AdsDetails> {
  TextEditingController msg = TextEditingController();
  String name = "";
  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }

  Future newsubmit(String username) async {
    var url = "https://influxdev.com/bdb/books/sendmsg.php";
    var responsez = await http.post(url, body: {
      "name": name,
      "username": username,
      "msg": msg.text,
    });
    var data = json.decode(responsez.body);
    msg.clear();

    if (data == 'Sent to user') {
      Fluttertoast.showToast(
          msg: "Message Sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Sorry Message was not sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  sendMsgDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Write 120 Words"),
            content: TextField(
              controller: msg,
            ),
            actions: [
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Send'),
                onPressed: () {
                  newsubmit(widget.product.username);
                  setState(() {});
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Book's Details",
              style: TextStyle(fontFamily: 'Gatter', fontSize: 25.0),
            ),
            backgroundColor: Colors.blue,
            expandedHeight: 350.0,
            flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
              child: Image.network(widget.product.bookPhoto, fit: BoxFit.cover),
            )),
          ),
          SliverFillRemaining(
            child: ListView(children: <Widget>[
              ListTile(
                leading: Icon(Icons.book),
                title: Text("Name"),
                subtitle: Text(
                  widget.product.bookName,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Author"),
                subtitle: Text(
                  widget.product.authorName,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.attach_money),
                title: Text("Price (৳)"),
                trailing: Text(
                  widget.product.bookPrice,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.book_online),
                title: Text("Book Condition"),
                trailing: Text(
                  widget.product.bookCond,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.connect_without_contact),
                title: Text("Post Condition"),
                trailing: Text(
                  widget.product.postCond,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text("Meeting Place"),
                subtitle: Text(
                  widget.product.meetLoc,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.book_online),
                title: Text("Description"),
                subtitle: Text(
                  widget.product.postDes,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.translate),
                title: Text("Book Language"),
                trailing: Text(
                  widget.product.bookLang,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_box),
                title: Text("Posted By"),
                trailing: Text(
                  widget.product.username.toUpperCase(),
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.call),
                title: Text("Mobile No"),
                trailing: Text(
                  widget.product.usermobile,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                onPressed: () {
                  sendMsgDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.message_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      " Message to Seller",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "getter",
                          fontSize: 20.0),
                    ),
                  ],
                ),
                color: Colors.blue,
                padding: EdgeInsets.all(15.0),
              ),
            ]),
          )
        ],
      )),
    );
  }
}

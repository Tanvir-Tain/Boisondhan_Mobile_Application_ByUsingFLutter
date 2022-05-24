import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newproject/message_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'msg_details_modal.dart';

class MsgDetails extends StatefulWidget {
  final MsgModel product;
  MsgDetails(this.product);

  @override
  _MsgDetailsState createState() => _MsgDetailsState();
}

class _MsgDetailsState extends State<MsgDetails> {
  TextEditingController msg = TextEditingController();
  String name = "";
  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
    
  }

  Future submit(String username) async {
    
    var url = "https://influxdev.com/bdb/books/msg2.php";
    var response = await http.post(url, body: {
      "name": name,
      "username": username,
    });

    return msgDetailsModalFromJson(response.body);
  }

  Future newsubmit(String username) async{
    
    var url = "https://influxdev.com/bdb/books/sendmsg.php";
    var responsez = await http.post(url,body:{
      "name": name,
      "username" : username,
      "msg": msg.text,
    });
    setState(() {});
    var data = json.decode(responsez.body);
    msg.clear();

    if(data == 'Sent to user'){
      Fluttertoast.showToast(
        msg: "Message Sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

    }
    else{
      Fluttertoast.showToast(
        msg: "Sorry Message was not sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

    }

  }

  @override
  void initState() {
    super.initState();
    getName();
    Timer.periodic(Duration(seconds: 1), (_) => submit(widget.product.username));
    
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.username.toUpperCase()),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: FutureBuilder(
              future: submit(widget.product.username),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        MsgDetailsModal product = snapshot.data[index];
                        return Container(
      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
      child: Align(
        alignment: ('${product.senderId}'== '${product.userId}'?Alignment.topRight:Alignment.topLeft),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ('${product.senderId}'== '${product.userId}'?Colors.blue[200]:Colors.grey.shade200),
          ),
          padding: EdgeInsets.all(16),
          child: Text('${product.msg}', style: TextStyle(fontSize: 15),),
        ),
      ),
    );
                      });
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: msg,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      newsubmit(widget.product.username);
                      setState(() {});
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

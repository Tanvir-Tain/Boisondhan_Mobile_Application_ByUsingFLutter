import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newproject/message_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'message_details.dart';

class MsgPost extends StatefulWidget {
  @override
  _MsgPostState createState() => _MsgPostState();
}

class _MsgPostState extends State<MsgPost> {
  String name = "";
  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }
  Future register() async {
    var url = "https://influxdev.com/bdb/books/msg.php";
    var response = await http.post(url, body: {
      "name": name,
    });
    return msgModelFromJson(response.body);
  }

  String _capitalize(String value) {
    return value.substring(0, 1).toUpperCase() +
        value.substring(1, value.length);
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Container(
        child: FutureBuilder(
          future: register(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    MsgModel product = snapshot.data[index];
                    return GestureDetector(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 90,
                          padding: const EdgeInsets.all(0),
                          child: Row(children: [
                            Expanded(
                              flex: 6,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                            NetworkImage('${product.proPic}'),
                                        fit: BoxFit.cover)),
                                height: 75.0,
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 13,
                              child: Container(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      (_capitalize("${product.username}")),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MsgDetails(product)));
                              
                    },
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

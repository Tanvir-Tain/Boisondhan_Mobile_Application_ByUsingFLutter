import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newproject/user_posts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserPost extends StatefulWidget {
  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  TextEditingController bookName = TextEditingController();
  TextEditingController bookPrice = TextEditingController();
  TextEditingController authorName = TextEditingController();

  String name = "";
  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }

  Future register() async {
    var url = "https://influxdev.com/bdb/books/user_posts.php";
    var response = await http.post(url, body: {
      "name": name,
    });
    return userPostModelFromJson(response.body);
  }

  Future postdelete(String postID) async{
    
    var url = "https://influxdev.com/bdb/books/user_post_dlt.php";
    var responsez = await http.post(url,body:{
      "name": name,
      "postID": postID,
    });
    setState(() {});
    var data = json.decode(responsez.body);
    print(data);

    if(data == 'Data Delete'){
      Fluttertoast.showToast(
        msg: "Ads Deleted",
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
        msg: "Sorry Ads was not deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

    }

  }


  editUserPost(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Your Ads Edit'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
              controller: bookName,
               
            ),
            TextField(
              controller: bookPrice,
               
            ),
            TextField(
              controller: authorName,
               
            )
              ],
            ),
            actions: [
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Update'),
                onPressed: () {
                  // newsubmit(widget.product.username);
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
      appBar: AppBar(
        title: Text("Your Posts"),
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
                    UserPostModel product = snapshot.data[index];
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.all(0),
                        child: Row(children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          NetworkImage('${product.bookName}'),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 14,
                            child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("${product.bookName}",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '${product.authorName}',
                                        style: TextStyle(fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        FlatButton(
                                            onPressed: (){
                                              postdelete('${product.postId}');
                                            },
                                            child: Text("Delete")),
                                        FlatButton(
                                            onPressed:  (){
                                              bookName.text = '${product.bookName}';
                                              bookPrice.text = '${product.bookPrice}';
                                              authorName.text = '${product.authorName}';
                                              editUserPost(context);
                                            },
                                            child: Text("Edit")),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
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

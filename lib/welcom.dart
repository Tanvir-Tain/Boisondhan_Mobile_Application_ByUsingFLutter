
import 'package:flutter/material.dart';
import 'package:newproject/posts.dart';   // adds post / item4
import 'package:newproject/signin.dart';
import 'package:newproject/user_details_modal.dart';
import 'package:newproject/user_post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import 'add_post.dart';
import 'message.dart';   //item5 inbox

// ignore: camel_case_types
class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

// ignore: camel_case_types
class _welcomeState extends State<welcome> {
String name ="";
  Future getName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }

   Future userDetails() async {
    var url = "https://influxdev.com/bdb/books/user_details.php";
    var response = await http.post(url, body: {
      "name": name,
    });
    return userDetailsModalFromJson(response.body);
  }


  ////////////////
Future postdeletett() async{

  var url = "https://influxdev.com/bdb/books/wellcomemsg.php";
  var responsez = await http.post(url,body:{
    "name": name,
  });
  setState(() {});
  var data = json.decode(responsez.body);
  print(data);

  if(data =='Data Delete'){
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

  ///////////////////////



Future logOut(BuildContext context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('name');
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage()));
  }

Widget setupAlertDialoadContainer() {
  return Container(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: FutureBuilder(
      future: userDetails(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index){
                UserDetailsModal product = snapshot.data[index];
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('${product.username}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.mail),
                        title: Text('${product.usermail}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.call),
                        title: Text('${product.userMobile}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.school),
                        title: Text('${product.university}'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.create),
                        title: Text('${product.registrationdate}'),
                      ),
                    )
                  ],

                );

              }
            );
          }
           return Center(child: CircularProgressIndicator());
        }
    )
  );
}






  showDetailsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("User Details"),
            content: setupAlertDialoadContainer(),
            actions: [
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }


  @override
  void initState(){
    super.initState();
    getName();
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Dashboard")),
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children:[
  //         Center(
  //           child: Text(name),
  //           ),
  //           SizedBox(height: 20.0),
  //           MaterialButton(
  //             color: Colors.blue,
  //             onPressed: (){
  //               logOut(context);
  //             },child: Text("Log Out", style: TextStyle(color: Colors.white)),
  //             )
  //       ]
  //     )
      
  //   );
  // }

   Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text("Hello"+" "+name.toUpperCase()),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Sign Out'),
                  onTap: () {
                    logOut(context);
                  },
                ),
              ],
            ),
          )
,
      appBar: AppBar(
        title: Text("DASHBOARD"),
        elevation: .1,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeDashboardItem(name, Icons.person_outline_rounded),
            makeDashboardItem2("Create Book's Ads", Icons.post_add),
            makeDashboardItem3("Your Book's Ads", Icons.notifications_active_outlined),
            makeDashboardItem4("All Book's Ads", Icons.list_alt_outlined),
            makeDashboardItem5("Inbox", Icons.mark_email_unread),
            
          ],
        ),
      ),
      
    );
  }

  Card makeDashboardItem2(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageDemo()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }

  Card makeDashboardItem3(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserPost()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }


  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              showDetailsDialog(context);
              postdeletett();
             // Navigator.push(context, MaterialPageRoute(builder: (context) => postdeletett()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }



  

  Card makeDashboardItem4(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdsPost()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }

   Card makeDashboardItem5(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MsgPost()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }



}
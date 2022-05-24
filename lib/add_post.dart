import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImageDemo extends StatefulWidget {
  UploadImageDemo() : super();

  final String title = "Upload Image Demo";

  @override
  UploadImageDemoState createState() => UploadImageDemoState();
}

class UploadImageDemoState extends State<UploadImageDemo> {
  //
  TextEditingController bookName = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController bookPrice = TextEditingController();
  // TextEditingController bookCond = TextEditingController();
  // TextEditingController postCond = TextEditingController();
  TextEditingController postDes = TextEditingController();
  TextEditingController meetLoc = TextEditingController();
  TextEditingController userID = TextEditingController();
  TextEditingController bookLang = TextEditingController();
 

  String name ="";
  Future getName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }




  String valueChoose;
  List listItem = ["Academic Engg", "Academic General"];
  String bookCond;
  List listItem1 = ["Used", "New"];
  String postCond;
  List listItem2 = ["Fixed", "Negotiable", "Partial"];


  static final String uploadEndPoint =
      'https://influxdev.com/bdb/books/add_post.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      // ignore: deprecated_member_use
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    var bookLang2 = bookLang;
        upload(fileName, bookName, valueChoose, authorName, bookPrice, bookCond,postCond,postDes,meetLoc,bookLang2, name);
  }

  upload(String fileName, TextEditingController bookName, String valueChoose, TextEditingController authorName, TextEditingController bookPrice, String bookCond, String postCond, TextEditingController postDes, TextEditingController meetLoc, TextEditingController bookLang, String name) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
      "bookName": bookName.text,
      "category": valueChoose,
      "authorName": authorName.text,
      "bookPrice": bookPrice.text,
      "bookCond": bookCond,
      "postCond": postCond,
      "postDes": postDes.text,
      "meetLoc": meetLoc.text,
      "bookLang": bookLang.text,
      "userName": name,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget get showImage {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override

  void initState(){
    super.initState();
    getName();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Post"),
      ),
      body: SingleChildScrollView(
        child:
        Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              OutlineButton(
                onPressed: chooseImage,
                child: Text('Choose Image'),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: showImage,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: bookName,
                 
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.book),
                    labelText: 'Book Name',
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: authorName,
                  
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Author Name',
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: bookPrice,
                  
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.money),
                    labelText: 'Book Price',
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: DropdownButton(
                      hint: Text("Book Condition"),
                      value: bookCond,
                      icon: Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          bookCond = newValue;
                        });
                      },
                      items: listItem1.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem, child: Text(valueItem));
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: DropdownButton(
                      hint: Text("Post Condition"),
                      value: postCond,
                      icon: Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          postCond = newValue;
                        });
                      },
                      items: listItem2.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem, child: Text(valueItem));
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: DropdownButton(
                      hint: Text("Select Category"),
                      value: valueChoose,
                      icon: Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue;
                        });
                      },
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem, child: Text(valueItem));
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: postDes,
                  
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.details),
                    labelText: 'Short Description',
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: meetLoc,
                  
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.map),
                    labelText: 'Location',
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: bookLang,
                 
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.language),
                    labelText: 'Book Language',
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              OutlineButton(
                onPressed: startUpload,
                child: Text('Submit Post'),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:newproject/ads_details.dart';//productdetails
import 'post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<ProductModel>> fetchProducts() async {
  String url = "https://influxdev.com/bdb/books/ads_post.php";
  final resz = await http.get(url);
  return productModelFromJson(resz.body);
}

class AdsPost extends StatefulWidget {
  @override
  _AdsPostState createState() => _AdsPostState();
}

class _AdsPostState extends State<AdsPost> {

  String name = "";
  Future getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }

  Future<List<ProductModel>> fetchProducts() async {
  String url = "https://influxdev.com/bdb/books/ads_post.php";
  final resz = await http.post(url, body: {
      "name": name,
    });
  return productModelFromJson(resz.body);
}

  
  @override
   void initState() {
    super.initState();
    getName();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Ads"),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  ProductModel product = snapshot.data[index];
                  return GestureDetector(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: ClipRRect(
                                        child:
                                            Image.network('${product.bookPhoto}', alignment: Alignment.center, fit: BoxFit.fitHeight,),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0),
                                        )),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${product.bookName}'.toUpperCase(),
                                            style:
                                                // ignore: deprecated_member_use
                                                Theme.of(context)
                                                    .textTheme
                                                    // ignore: deprecated_member_use
                                                    .title,
                                          ),
                                          SizedBox(height: 16.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${product.bookPrice}' +
                                                  'TK'),
                                              Text('${product.meetLoc}'),
                                              Text('${product.postCreated}'),
                                            ],
                                          )
                                        ],
                                      ))
                                ]),
                          )),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdsDetails(product)));
                    },
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

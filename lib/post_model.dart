import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    ProductModel({
        this.postId,
        this.bookName,
        this.bookPhoto,
        this.authorName,
        this.bookPrice,
        this.bookCond,
        this.postCond,
        this.postDes,
        this.meetLoc,
        this.userId,
        this.catId,
        this.bookLang,
        this.postCreated,
        this.username,
        this.usermobile,
    });

    String postId;
    String bookName;
    String authorName;
    String bookPhoto;
    String bookPrice;
    String bookCond;
    String postCond;
    String postDes;
    String meetLoc;
    String userId;
    String catId;
    String bookLang;
    String postCreated;
    String username;
    String usermobile;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        postId: json["postID"],
        bookName: json["bookName"],
        bookPhoto: "https://influxdev.com/bdb/books/"+json['bookPhoto'],
        authorName: json["authorName"],
        bookPrice: json["bookPrice"],
        bookCond: json["bookCond"],
        postCond: json["postCond"],
        postDes: json["postDes"],
        meetLoc: json["meetLoc"],
        userId: json["userID"],
        catId: json["catID"],
        bookLang: json["bookLang"],
        postCreated: json["postCreated"],
        username: json["username"],
        usermobile: json["usermobile"],
    );

    Map<String, dynamic> toJson() => {
        "postID": postId,
        "bookName": bookName,
        "bookPhoto": bookPhoto,
        "authorName": authorName,
        "bookPrice": bookPrice,
        "bookCond": bookCond,
        "postCond": postCond,
        "postDes": postDes,
        "meetLoc": meetLoc,
        "userID": userId,
        "catID": catId,
        "bookLang": bookLang,
        "postCreated": postCreated,
        "username": username,
        "usermobile": usermobile,
    };
}

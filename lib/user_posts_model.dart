import 'dart:convert';

List<UserPostModel> userPostModelFromJson(String str) => List<UserPostModel>.from(json.decode(str).map((x) => UserPostModel.fromJson(x)));

String userPostModelToJson(List<UserPostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserPostModel {
    UserPostModel({
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
        this.username,
        this.postCreated,
    });

    String postId;
    String bookName;
    String bookPhoto;
    String authorName;
    String bookPrice;
    String bookCond;
    String postCond;
    String postDes;
    String meetLoc;
    String userId;
    String catId;
    String bookLang;
    String username;
    DateTime postCreated;

    factory UserPostModel.fromJson(Map<String, dynamic> json) => UserPostModel(
        postId: json["postID"],
        bookName: json["bookName"],
        bookPhoto: "http://https://influxdev.com/bdb/books/"+json['bookPhoto'],
        authorName: json["authorName"],
        bookPrice: json["bookPrice"],
        bookCond: json["bookCond"],
        postCond: json["postCond"],
        postDes: json["postDes"],
        meetLoc: json["meetLoc"],
        userId: json["userID"],
        catId: json["catID"],
        bookLang: json["bookLang"],
        username: json["username"],
        postCreated: DateTime.parse(json["postCreated"]),
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
        "username": username,
        "postCreated": "${postCreated.year.toString().padLeft(4, '0')}-${postCreated.month.toString().padLeft(2, '0')}-${postCreated.day.toString().padLeft(2, '0')}",
    };
}
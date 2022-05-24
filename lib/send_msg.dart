import 'package:flutter/material.dart';
import 'package:newproject/post_model.dart';

class SendMsg extends StatelessWidget {
  final ProductModel product;
  SendMsg(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message to Seller"),
      ),
      
    );
  }
}
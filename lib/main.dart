import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Test(),
      ),
    ),
  );
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List posts = [];
  Future getPost() async {
    var url = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    posts.addAll(responseBody);
    print(responseBody);
  }

  @override
  void initState() {
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: posts == null || posts.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, i) {
                  return Text("${posts[i]['title']}");
                }));
  }
}

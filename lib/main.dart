import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
        //Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        Uri.encodeFull("https://randomuser.me/api/?results=20"),
        headers: {
          "Accept": "application/json"
        }
    );
    //print(response.body.split(",").join("\n"));
    //print(someData["results"]);
    this.setState(() {
      var someData = JSON.decode(response.body);
      data = someData["results"];
    });

    for(int i = 0; i < data.length; i++) {
      print(data[i]["name"]["first"] + " (" + data[i]["gender"] + ")");
      print(data[i]["picture"]["thumbnail"]);
      //print(data[i]["picture"] + ", " + data[i]["picture"]["medium"]);//thumbnail  large  //NoSuchMethodError: Class '_InternalLinkedHashMap<String, dynamic>' has no instance method '+'.
    }
    return "Success!";
  }

  /*
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          child: new Text("Get data"),
          onPressed: getData,
        ),
      ),
    );
  }*/

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Portfolio"),
      ),
      body: //new Column(
        //children: [
          /*
          new Center(
            child: new RaisedButton(
              child: new Text("Get data"),
              onPressed: getData,
            ),
          ),*/
         new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                elevation: 2.0,
                child:
                new Row(
                  children: <Widget>[
                    new Text(data[index]["name"]["first"] + " "
                        + data[index]["name"]["last"] + " ("
                        + data[index]["gender"] + ")"),
                    Image.network(
                      data[index]["picture"]["large"],
                    )
                  ],
                ),
              );
            },
          ),
       // ]
     // )
    );
  }
}


/*

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Listviews"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(data[index]["title"]),
          );
        },
      ),
    );
  }

*/

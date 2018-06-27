import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:random_words/random_words.dart';

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
        Uri.encodeFull("https://randomuser.me/api/?results=50"),
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

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

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
              var firstName = capitalize(data[index]["name"]["first"]);
              var lastName = capitalize(data[index]["name"]["last"]);
              var fullName =  firstName + " " + lastName;

              return new Card(
                elevation: 2.0,
                child:
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Column(
                        children: [
                          new Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(data[index]["picture"]["large"])
                                  )
                              )),
                          new Text(fullName, textScaleFactor: 1.5)
                        ]
                    ),
                    new Expanded(
                      child: new Column(
                        children: [
                          new Text(data[index]["gender"]
                              + " and formerly known as "
                              + data[index]["login"]["username"]
                          ),
                          new Text(
                              (data[index]["gender"] == "male"? "He" : "She")
                              + " is " + generateAdjective().take(1).elementAt(0).asLowerCase
                          ),
                        ]
                      ),
                    ),
                    //Image.network(data[index]["picture"]["large"]),
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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:random_words/random_words.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // MIT License

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
        Uri.encodeFull("https://randomuser.me/api/?results=10"),
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
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          var firstName = capitalize(data[index]["name"]["first"]);
          var lastName = capitalize(data[index]["name"]["last"]);
          var fullName =  firstName + " " + lastName;
          String gender = data[index]["gender"];
          String username = data[index]["login"]["username"];
          String genderPronoun = gender == "male" ? "He" : "She";

          return new Card(
              elevation: 2.0,
              child: new InkWell(
                onTap: () => print("OK cool!"),
                child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: new Column(children: <Widget>[
                        new Container(
                          width: 160.0,
                          height: 160.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(data[index]["picture"]["large"])
                            )
                          )
                        ),
                        new SizedBox(height: 10.0,),
                        new Row(children: <Widget>[
                          new Text(firstName, textScaleFactor: 1.5),
                          (gender == "male") ?
                            new Icon(FontAwesomeIcons.mars, color: Colors.blue,)
                            :
                            new Icon(FontAwesomeIcons.venus, color: Colors.pinkAccent)
                        ]),
                    ]),
                  ),
                  new Expanded(
                    child: new Padding(
                      padding: new EdgeInsets.all(20.0),
                      child:
                      new Column(children: [
                        new Text(
                          "$fullName is formerly known as:\n",
                          style: new TextStyle(
                            fontSize: 18.0
                          )
                        ),
                        new Text(
                          username,
                          style: new TextStyle(
                              fontSize: 22.0
                          )
                        ),
                        new Text(
                          "\n" + genderPronoun + " is " + generateAdjective().take(1).elementAt(0).asLowerCase,
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                          )
                        ),
                      ])
                    )
                  ),
                ],
              ),
            )
          );
        },
      ),
    );
  }
}
//Image.network(data[index]["picture"]["large"]),


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

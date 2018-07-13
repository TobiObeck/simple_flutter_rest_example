import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:random_words/random_words.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // MIT License

import 'ApiObject.dart';

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
      var someData = json.decode(response.body);//or jsonDecode();  JSON.decode() is deprecated.
      data = someData["results"];

      Map userMap = json.decode(response.body);
      print("no error1");
      //var user = new ApiObject.fromJson(userMap);
      //print("no error2");
      //print(user);
    });

    for(int i = 0; i < data.length; i++) {
      //print(data[i]["name"]["first"] + " (" + data[i]["gender"] + ")");
      //print(data[i]["picture"]["thumbnail"]);
      //print(data[i]["picture"] + ", " + data[i]["picture"]["medium"]);//thumbnail  large  //NoSuchMethodError: Class '_InternalLinkedHashMap<String, dynamic>' has no instance method '+'.
    }
    return "Success!";
  }

  final scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

  Widget _buildPersonPortraitWidget(data){

    var firstName = capitalize(data["name"]["first"]);
    var lastName = capitalize(data["name"]["last"]);
    var fullName =  firstName + " " + lastName;
    String gender = data["gender"];
    String username = data["login"]["username"];
    String imgUrl = data["picture"]["large"];

    String genderPronoun = gender == "male" ? "He" : "She";
    Icon genderIcon = (gender == "male") ? new Icon(FontAwesomeIcons.mars, color: Colors.blue)
        : new Icon(FontAwesomeIcons.venus, color: Colors.pinkAccent);

    Widget _labeledImageWidget = _buildLabeledImageWidget(firstName, imgUrl, genderIcon);
    Widget _informationWidget = _buildInformationWidget(fullName, username, genderPronoun);

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _labeledImageWidget,
        _informationWidget
      ],
    );
  }

  Widget _buildLabeledImageWidget(firstName, largeImageUrl, Icon genderIcon){
    return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new Column(children: <Widget>[
        new Container(
          width: 160.0,
          height: 160.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(largeImageUrl)
            )
          )
        ),
        new SizedBox(height: 10.0,),
        new Row(children: <Widget>[
          new Text(firstName, textScaleFactor: 1.5),
          genderIcon
        ])
      ])
    );
  }

  Widget _buildInformationWidget(String fullName, String username, String genderPronoun){
    return new Expanded(
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
    );
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Portfolio"),
      ),
      body: new ListView.builder(
        controller: scrollController,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          Widget personPortraitWidget = _buildPersonPortraitWidget(data[index]);

          return new Card(
            elevation: 2.0,
            child: new InkWell(
              onTap: () => print("OK cool!"),
              child: personPortraitWidget
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

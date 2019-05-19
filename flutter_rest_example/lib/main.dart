import 'package:flutter/material.dart';

//void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Title in multitasking',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Scaffold title in appbar'),
            ),
            body: MyHomePage()
        )
    );
  }
}

class MyHomePage extends StatelessWidget {

  final String imageUrl = "https://randomuser.me/api/portraits/women/3.jpg";

  @override
  Widget build(BuildContext context) {
    return Center(      child:
    Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(imageUrl),
          new Text("Jane Doe", textAlign: TextAlign.left),
        ],
      )//Dart has no problem with trailing commas
    );
  }
}
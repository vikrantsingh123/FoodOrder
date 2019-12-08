import 'package:flutter/material.dart';
import 'package:test1/rectangle.dart';

void main() => runApp(MyStateWidget());

class MyStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('YO'),
        ),
        body: Rectangle(),
      ),
    );
  }
}

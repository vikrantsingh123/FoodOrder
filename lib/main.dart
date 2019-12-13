import 'package:flutter/material.dart';
import 'package:test1/screens/HangingList/hangingList.dart';

void main() => runApp(MaterialApp(
      title: 'TASTYBURGER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: MyStateWidget(),
    ));

class MyStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'TASTYBURGER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Icon(Icons.fastfood),
          Padding(
            padding: EdgeInsets.all(5),
          )
        ],
      ),
      body: HangingList(),
    );
  }
}

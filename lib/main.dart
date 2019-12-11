import 'package:flutter/material.dart';
import 'package:test1/screens/HangingList/hangingList.dart';

void main() => runApp(MaterialApp(
      title: 'Navigation Basics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: MyStateWidget(),
    ));

class MyStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HangingList',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
        ),
      ),
      body: HangingList(),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: Text('Drawer Header'),
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //       ),
      //       ListTile(
      //         title: Text('HangingItem '),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => RectangleList()));

      //           // Update the state of the app
      //           // ...
      //           // Then close the drawer
      //           // Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Hanging List'),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => RectangleList()));
      //           // Update the state of the app
      //           // ...
      //           // Then close the drawer
      //           // Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

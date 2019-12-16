import 'package:flutter/material.dart';
import 'package:hanginglist/hanginglist.dart';

import 'model/hangingObj.dart';

void main() => runApp(MaterialApp(
      title: 'Hanging List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: MyStateWidget(),
    ));

class MyStateWidget extends StatelessWidget {
  double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'HANGING LIST',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: 0.8),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Icon(Icons.fastfood),
          Padding(
            padding: EdgeInsets.all(5),
          )
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   colors: [Colors.black26, Colors.black45, Colors.black54],
        //   begin: FractionalOffset(1.0, 1.0),
        //   end: FractionalOffset(1.7, 0.0),
        //   stops: [
        //     0.0,
        //     0.5,
        //     1.0,
        //   ],
        // )),
        child: HangingList(
          list: list,
          frontSide: frontSide,
          backSide: backSide,
          moveList: true,
          moveListItem: false,
          height: screenHeight / 1.7,
          width: screenWidth / 1.3,
        ),
      ),
    );
  }

// Create a generic function which returns the frontSide widget of the card
  Widget frontSide<HangingObject>(obj) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                obj.restaurantName,
                style: TextStyle(fontSize: 30, color: Color(0xffb71c1c)),
              ),
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Text(obj.restaurantName),
            // ),
            SizedBox(
              height: 10,
            ),
            Image.asset(obj.dishImage, height: screenHeight / 3.2),
            SizedBox(
                width: 200,
                child: RaisedButton(
                  color: Color(0xffffab40),
                  onPressed: () {},
                  child: Text(
                    'Add to your order',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xffff6d00))),
                ))
          ],
        ));
  }

// Create a generic function which returns the backSide widget of the card
  Widget backSide<HangingObject>(obj) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(obj.restaurantName,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffb71c1c))),
          ),
          Hero(
            tag: 'tastyBurger',
            child: Image.asset(
              obj.logo,
              height: 80,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: screenHeight / 4,
            child: ListView(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Dishes:',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.brown,
                          fontWeight: FontWeight.w600)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(obj.dishes, style: TextStyle(fontSize: 16)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Location:',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.brown,
                          fontWeight: FontWeight.w600)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(obj.location),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Contact:',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.brown,
                          fontWeight: FontWeight.w600)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(obj.contact),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 200,
              child: RaisedButton(
                color: Color(0xffffab40),
                onPressed: () {},
                child: Text(
                  'ORDER NOW',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xffff6d00))),
              ))
        ],
      ),
    );
  }

  List<HangingObject> list = [
    HangingObject(
        'Chicken',
        'assets/Image/mcDonald.png',
        'chicken',
        'assets/Image/mcFries.png',
        'McDonald`s',
        'Chicken McNuggets\nBig Mac\nFries',
        'Fusion Mall,2ndStage, Kormangala',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Burger',
        'assets/Image/tacoBell.png',
        'burger',
        'assets/Image/milkshake.png',
        'Taco Bell',
        'Doritos Locos Tacos\nFreezes\nNacho Fries\nThe Meximelt',
        'Ashwini Complex, Indranagar',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Pizza',
        'assets/Image/kfc.png',
        'pizza',
        'assets/Image/hotDog.png',
        'KFC',
        'Boneless Wings\nExtra Crispy Strips\nExtra Crispy Chicken\nHot Wings',
        'BDA Complex HSR',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Fries',
        'assets/Image/burgerKing.png',
        'fries',
        'assets/Image/burger.png',
        'Burger King',
        'Whopper Jr. Sandwich\nHamBurger\nVeggie Burger\nTENDERGRILL',
        'Bull Temple Road, Basavanagudi',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Coke',
        'assets/Image/subway.jpg',
        'coke',
        'assets/Image/cake.png',
        'Subway',
        'Rotisserie-Style Chicken\nVeggie Delite\nMeatball Marinara\nMeatball Marinara',
        'Fusion Mall,2ndStage, Kormangala',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Sandwich',
        'assets/Image/starBucks.png',
        'sandwich',
        'assets/Image/softDrink.png',
        'StarBucks',
        'Cake pops\nPumpkin bread\nGreek yogurt\nBacon',
        'Orion East, Banaswadi',
        '1860 210 0000, 080 3399 4444')
  ];
}

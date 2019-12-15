import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test1/model/hangingObj.dart';
import 'dart:math';
import 'package:test1/widgets/HangingItem/hangingItem.dart';

class HangingList extends StatefulWidget {
  @override
  _HangingListState createState() => _HangingListState();
}

class _HangingListState extends State<HangingList>
    with SingleTickerProviderStateMixin {
  double _angle = 0;
  AnimationController animationController;
  Animation<double> animation;

  PageController _pageController;
  bool endAnim = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });

    animationController =
        AnimationController(duration: Duration(milliseconds: 1500), vsync: this)
          ..addListener(() {});
  }

  initialiseAngle(bool left) {
    double angle = pi / 16;
    if (left == true) {
      angle = -angle;
    }
    animation = Tween(begin: angle, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
        } else if (notification is ScrollUpdateNotification) {
          setState(() {
            if (_pageController.position.userScrollDirection ==
                ScrollDirection.forward) {
              _angle = pi / 16;
            } else
              _angle = -pi / 16;
          });
        } else if (notification is ScrollEndNotification) {
          print(
              'axisDirection3 ${_pageController.position.userScrollDirection}');
          try {
            setState(() {
              print('reached');
              endAnim = true;
            });
            if (_pageController.position.userScrollDirection ==
                ScrollDirection.forward) {
              initialiseAngle(true);
            } else {
              initialiseAngle(false);
            }
            animationController.forward(from: 0.0).orCancel.then((onValue) {
              setState(() {
                print('reached2');
                _angle = 0;
                endAnim = false;
              });
            });
          } on TickerCanceled {}
        }
        return false;
      },
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            if (endAnim) {
              _angle = animation.value;
            } else {
              _angle = _angle;
            }
            return Transform.rotate(
                angle: _angle,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
                    child: HangingItem(list[index])));
          }),
    )
        // )
        );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List<HangingObject> list = [
    HangingObject(
        'Chicken',
        'assets/Image/mcDonald.png',
        'chicken',
        'assets/Image/mcFries.png',
        'McDonald`s',
        ['Chicken McNuggets', 'Big Mac', 'Fries'],
        'Fusion Mall,2ndStage, Kormangala',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Burger',
        'assets/Image/tacoBell.png',
        'burger',
        'assets/Image/milkshake.png',
        'Taco Bell',
        ['Doritos Locos Tacos', 'Freezes', 'Nacho Fries', 'The Meximelt'],
        'Ashwini Complex, Indranagar',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Pizza',
        'assets/Image/kfc.png',
        'pizza',
        'assets/Image/hotDog.png',
        'KFC',
        [
          'Boneless Wings',
          'Extra Crispy Strips',
          'Extra Crispy Chicken',
          'Hot Wings'
        ],
        'BDA Complex HSR',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Fries',
        'assets/Image/burgerKing.png',
        'fries',
        'assets/Image/burger.png',
        'Burger King',
        ['Whopper Jr. Sandwich', 'HamBurger', 'Veggie Burger', 'TENDERGRILL'],
        'Bull Temple Road, Basavanagudi',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Coke',
        'assets/Image/subway.jpg',
        'coke',
        'assets/Image/cake.png',
        'Subway',
        [
          'Rotisserie-Style Chicken',
          'Veggie Delite',
          'Meatball Marinara',
          'Meatball Marinara'
        ],
        'Fusion Mall,2ndStage, Kormangala',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Sandwich',
        'assets/Image/starBucks.png',
        'sandwich',
        'assets/Image/softDrink.png',
        'StarBucks',
        ['Cake pops', 'Pumpkin bread, Greek yogurt, Bacon'],
        'Orion East, Banaswadi',
        '1860 210 0000, 080 3399 4444')
  ];
}

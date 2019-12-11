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
                    child: HangingItem(list[index]))
                // Center(
                //     child: Padding(
                //         padding: EdgeInsets.all(20),
                //         child: Container(
                //           padding: EdgeInsets.all(200),
                //           height: 100,
                //           width: 100,
                //           color: Colors.red,
                //         )))
                );
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
    HangingObject('Chicken', 'chicken', Image.asset('../../Image/p1.jpg')),
    HangingObject('Burger', 'burger', Image.asset('../../Image/p1.jpg')),
    HangingObject('Pizza', 'pizza', Image.asset('../../Image/p1.jpg')),
    HangingObject('Fries', 'fries', Image.asset('../../Image/p1.jpg')),
    HangingObject('Coke', 'coke', Image.asset('../../Image/p1.jpg')),
  ];
}

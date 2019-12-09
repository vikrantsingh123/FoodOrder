import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test1/rectangle.dart';
import 'dart:math';

class RectangleList extends StatefulWidget {
  @override
  _RectangleListState createState() => _RectangleListState();
}

class _RectangleListState extends State<RectangleList>
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
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
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
          itemCount: 6,
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
                    child: Rectangle(index))
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
}

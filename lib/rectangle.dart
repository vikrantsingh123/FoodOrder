import 'dart:math';

import 'package:flutter/material.dart';

class Rectangle extends StatefulWidget {
  int num;
  Rectangle(this.num);
  @override
  _RectangleState createState() => _RectangleState();
}

class _RectangleState extends State<Rectangle>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  _GuillotineAnimationStatus myAnimationStatus;
  double _angle = 0;
  Offset _start, _end;
  bool startAnim = false;

  @override
  void initState() {
    super.initState();
    myAnimationStatus = _GuillotineAnimationStatus.closed;

    animationController =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..addListener(() {});
  }

  void initialiseAnimationAngle() {
    animation = Tween(begin: _angle, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  _startDrag(DragStartDetails details) {
    setState(() {
      _start = details.globalPosition;
    });
  }

  _updateDrag(DragUpdateDetails details) {
    _end = details.globalPosition;
    setState(() {
      _angle = atan2(_end.dy - _start.dy, _end.dx - _start.dx) * (180 / pi);
      var _angle1 = atan2(0 - _start.dy, 0);
      var _angle2 = atan2(0 - _end.dy, _start.dx - _end.dx);
      _angle = 3 * (_angle1 - _angle2);

      _angle = -_angle;
      // if (_angle < 0) {
      //   _angle = 0;
      // }
      // _angle = 1;
    });
  }

  _endDrag(DragEndDetails details) async {
    try {
      setState(() {
        startAnim = true;
      });
      initialiseAnimationAngle();

      await animationController.forward(from: 0.0).orCancel;
    } on TickerCanceled {}

    setState(() {
      startAnim = false;
      _angle = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double _animationAngle;

    if (startAnim) {
      _animationAngle = animation.value;
    } else {
      _animationAngle = _angle;
    }

    return Center(
        child: GestureDetector(
      onHorizontalDragStart: _startDrag,
      onHorizontalDragUpdate: _updateDrag,
      onHorizontalDragEnd: _endDrag,
      child: Container(
        height: screenHeight / 2,
        width: screenWidth / 1.3,
        child: Transform.rotate(
          angle: _animationAngle,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 5,
            // child: Text(
            //   widget.num.toString(),
            //   style: TextStyle(color: Colors.black, fontSize: 20),
            // ),
            color: Colors.green,
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

enum _GuillotineAnimationStatus { closed, open, animating }

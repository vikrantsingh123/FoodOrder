import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test1/model/hangingObj.dart';

class HangingItem extends StatefulWidget {
  HangingObject hangingItem;
  HangingItem(this.hangingItem);
  @override
  _HangingItemState createState() => _HangingItemState();
}

class _HangingItemState extends State<HangingItem>
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

          child: Container(
              decoration: BoxDecoration(
                // color: Colors.yellow,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                      offset: Offset(20.0, 20.0))
                ],
                gradient: LinearGradient(
                  colors: [Color(0xfffff9c4), Color(0xfffffde7)],
                  begin: FractionalOffset(1.0, 1.0),
                  end: FractionalOffset(1.7, 0.0),
                  stops: [0.0, 1.0],
                ),
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.hangingItem.title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget.hangingItem.title),
                  ),
                  Image(
                    image: AssetImage('assets/Image/p1.jpg'),
                  )
                ],
              )),

          // child: Text(
          //   widget.num.toString(),
          //   style: TextStyle(color: Colors.black, fontSize: 20),
          // ),
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

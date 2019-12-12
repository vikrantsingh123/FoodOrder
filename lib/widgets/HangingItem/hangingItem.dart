import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test1/model/hangingObj.dart';
import 'package:test1/screens/cardPage/cardPage.dart';
import 'package:test1/widgets/HangingItem/hangTransform.dart';

class HangingItem extends StatefulWidget {
  HangingObject hangingItem;
  HangingItem(this.hangingItem);
  @override
  _HangingItemState createState() => _HangingItemState();
}

typedef void BoolCallback(bool isFront);

class _HangingItemState extends State<HangingItem>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController _flipController;

  Animation<double> _frontScale;
  Animation<double> _backScale;

  Animation<double> animation;

  double _angle = 0;
  Offset _start, _end;
  bool startAnim = false, isFront = true;
  Widget front, back;
  VoidCallback onFlip;
  BoolCallback onFlipDone;
  bool flipOnTouch;
  double screenWidth;
  double screenHeight;
  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..addListener(() {});
    _flipController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _frontScale = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(_flipController);
    _backScale = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(_flipController);
    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (onFlipDone != null) onFlipDone(isFront);
      }
    });
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

      animationController.forward(from: 0.0).orCancel.then((value) {
        setState(() {
          startAnim = false;
          _angle = 0;
        });
      });
    } on TickerCanceled {}
  }

  _openCard() {
    print('opencard called');
    if (onFlip != null) {
      onFlip();
    }
    if (isFront) {
      print('forwardyo');
      _flipController.forward(from: 0.0).orCancel.then((onValue) {
        setState(() {
          isFront = !isFront;
        });
      });
    } else {
      print('reverseyo');
      _flipController.reverse().orCancel.then((onValue) {
        setState(() {
          isFront = !isFront;
        });
      });
    }

    // Navigator.push(context, CardPageRoute());
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    double _animationAngle;
    // Animation<double> flipScale;

    if (startAnim) {
      _animationAngle = animation.value;
    } else {
      _animationAngle = _angle;
    }
    // if (flipCard) {
    //   flipScale = _frontScale
    // } else {
    //   flipScale = _backScale;
    // }

    return Center(
      child: GestureDetector(
          onHorizontalDragStart: _startDrag,
          onHorizontalDragUpdate: _updateDrag,
          onHorizontalDragEnd: _endDrag,
          onTap: _openCard,
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              _buildContent(isUpSide: true, animationAngle: _animationAngle),
              _buildContent(isUpSide: false, animationAngle: _animationAngle)
            ],
          )),
    );
  }

  Widget _buildContent({@required bool isUpSide, double animationAngle}) {
    return IgnorePointer(
      ignoring: isUpSide ? !isFront : isFront,
      child: AnimationCard(
          animation: isUpSide ? _frontScale : _backScale,
          child1: widget.hangingItem,
          height: screenHeight,
          width: screenWidth,
          animationAngle: animationAngle,
          isUpside: isUpSide),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    _flipController.dispose();
    super.dispose();
  }
}

class AnimationCard extends StatelessWidget {
  final HangingObject child1;
  final Animation<double> animation;
  final double height, width, animationAngle;
  final bool isUpside;
  AnimationCard(
      {this.animation,
      this.child1,
      this.height,
      this.width,
      this.animationAngle,
      this.isUpside});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        final Matrix4 transform = new Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(animation.value);

        return HangTransform(
            transform, height, width, animationAngle, child1, isUpside);
      },
    );
  }
}

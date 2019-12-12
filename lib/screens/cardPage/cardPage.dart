import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class CardPageRoute extends ModalRoute<void> {
//   @override
//   Duration get transitionDuration => Duration(milliseconds: 100);

//   @override
//   bool get opaque => false;

//   @override
//   bool get barrierDismissible => false;

//   @override
//   Color get barrierColor => Colors.black.withOpacity(0.5);

//   @override
//   String get barrierLabel => null;

//   @override
//   bool get maintainState => true;
//   @override
//   Widget buildPage(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//   ) {
//     // This makes sure that text and other content follows the material style
//     return Material(
//       type: MaterialType.transparency,
//       // make sure that the overlay content is not cut off
//       child: SafeArea(
//         child: _buildOverlayContent(context),
//       ),
//     );
//   }

//   Widget _buildOverlayContent(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Text(
//             'This is a nice overlay',
//             style: TextStyle(color: Colors.white, fontSize: 30.0),
//           ),
//           RaisedButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Dismiss'),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     // You can add your own animations for the overlay content
//     return FadeTransition(
//       opacity: animation,
//       child: ScaleTransition(
//         scale: animation,
//         child: child,
//       ),
//     );
//   }
// }
class CardPageRoute extends CupertinoPageRoute {
  // CardPageRoute() : super(builder: (BuildContext context) => CardPage());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: CardPage(),
    );
  }
}

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Text('This is the second page'),
      ),
    );
  }
}
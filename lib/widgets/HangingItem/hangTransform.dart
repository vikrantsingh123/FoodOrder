import 'package:flutter/material.dart';
import 'package:test1/model/hangingObj.dart';

class HangTransform extends StatelessWidget {
  final Matrix4 transform;
  final double _height, _width, _animationAngle;
  final HangingObject _widget;
  final bool isUpside;
  HangTransform(this.transform, this._height, this._width, this._animationAngle,
      this._widget, this.isUpside);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: transform,
      child: Container(
        height: _height / 2,
        width: _width / 1.3,
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
              child: isUpside
                  ? Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            _widget.title,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(_widget.title),
                        ),
                        Image(
                          image: AssetImage('assets/Image/p1.jpg'),
                        )
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(_widget.restaurantName,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600)),
                          ),
                          Hero(
                            tag: 'tastyBurger',
                            child: Image.asset(
                              _widget.logo,
                              height: 80,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Dishes:',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w600)),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _widget.dishes.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Text(_widget.dishes[i],
                                  style: TextStyle(fontSize: 16));
                            },
                          ),
                          SizedBox(
                            height: 10,
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
                            child: Text(_widget.location),
                          ),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }
}

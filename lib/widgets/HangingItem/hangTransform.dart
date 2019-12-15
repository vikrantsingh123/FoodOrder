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
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                _widget.restaurantName,
                                style: TextStyle(
                                    fontSize: 30, color: Color(0xffb71c1c)),
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Text(_widget.restaurantName),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Image.asset(_widget.dishImage, height: 300),
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
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side:
                                          BorderSide(color: Color(0xffff6d00))),
                                ))
                          ],
                        ))
                    : Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(_widget.restaurantName,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffb71c1c))),
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
                              child: Text(_widget.contact),
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
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side:
                                          BorderSide(color: Color(0xffff6d00))),
                                ))
                          ],
                        ),
                      )),
          ),
        ));
  }
}

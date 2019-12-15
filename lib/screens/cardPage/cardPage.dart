import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardPageRoute extends StatefulWidget {
  final String logoAsset;
  CardPageRoute({this.logoAsset});
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPageRoute> {
  ScrollController _scrollController;
  bool lastStatus = true;
  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var decoratedBox = new DecoratedBox(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new AssetImage(widget.logoAsset),
        ),
        shape: BoxShape.rectangle,
      ),
    );

    var hero = new Hero(
      tag: 'tastyBurger',
      child: decoratedBox,
    );

    List<Widget> stackChildren = <Widget>[
      new Positioned.fill(child: hero),
    ];

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          new SliverAppBar(
            flexibleSpace: new FlexibleSpaceBar(
              title: Text('TASTYBURGER'),
              background: new Stack(
                children: stackChildren,
              ),
            ),
            pinned: true,

            // Extruding edge from the sliver appbar, may need to fix expanded height
            expandedHeight: MediaQuery.of(context).size.height / 2.5,
            backgroundColor: isShrink ? Colors.yellow : Colors.white,
          ),
          new SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Ingredients',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "\$ 3.75",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
                Container(
                    width: double.infinity,
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                            color: Color(0xfffff9c4),
                            margin: EdgeInsets.all(10),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.brown)),
                                      child: Image.asset(
                                        'assets/Image/fastFood.png',
                                        height: 100,
                                        width: 100,
                                      )),
                                  Column(
                                    children: <Widget>[
                                      Text('Cabbage'),
                                      Text('\$0.3')
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 50,
                                            child: RaisedButton(
                                              color: Colors.grey[300],
                                              onPressed: () {},
                                              child: Text('-'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('7'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 50,
                                            child: RaisedButton(
                                              color: Colors.grey[300],
                                              onPressed: () {},
                                              child: Text('+'),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ]));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Divider(
                              color: Colors.black,
                            ));
                      },
                    )),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text('Add to Cart'),
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

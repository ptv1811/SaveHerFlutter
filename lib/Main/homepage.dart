import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_her/Services/HandleAQI.dart';
import 'package:save_her/Tools/HexColor.dart';
import 'package:save_her/Widget/SlideCart.dart';

class HomePage extends StatefulWidget {

  final FlareControls controls;
  final String flare_animation;
  final Color background_color;
  final Color low_color;
  final Color bottom_navigation;

  const HomePage(
      {Key key,
        @required this.controls,@required this.flare_animation, @required this.background_color,
        @required this.low_color,@required this.bottom_navigation
      }):super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.low_color,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  color: widget.background_color,
                  height: ScreenUtil.getInstance().setHeight(370),
                  width: ScreenUtil.getInstance().setWidth(800),
                  child:Hero(
                    tag: 'fly',
                    child: FlareActor("assets/life.flr"
                      ,alignment: Alignment.bottomCenter,animation: widget.flare_animation,controller: widget.controls,),
                  )
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(left: 170,top:55),
                  child: HandleAQI()
                ),

                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(49),
                ),

                Container(
                  width: double.infinity,
                  height: ScreenUtil.getInstance().setHeight(2000),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(45.0), topLeft: Radius.circular(45.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0,top: 20,bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(0.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Container(
                                width: ScreenUtil.getInstance().setWidth(200.0),
                                height: ScreenUtil.getInstance().setHeight(200.0),
                                child: new FlareActor("assets/tree.flr",
                                  alignment: Alignment.center,animation: "animation",controller: widget.controls,),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                "Welcome to Save Her",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Avo",
                                    fontSize: ScreenUtil.getInstance().setSp(40.0)
                                ),
                              ),
                            )


                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(50.0),
                        ),
                        SlidingCardViews()
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.white,
        color: widget.bottom_navigation,
        items: <Widget>[
          Icon(Icons.list,size: 38,color: Colors.black,),
          Icon(Icons.account_circle,size: 38,color: Colors.black,)
        ],
      ),
    );
  }




}

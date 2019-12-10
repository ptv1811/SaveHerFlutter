import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_her/Services/HandleAQI.dart';

class HomePage extends StatefulWidget {

  final FlareControls controls;
  final String flare_animation;

  const HomePage(
      {Key key,
        @required this.controls,@required this.flare_animation
      }):super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0d2d41),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  height: ScreenUtil.getInstance().setHeight(400),
                  width: ScreenUtil.getInstance().setWidth(800),
                  child:Hero(
                    tag: 'fly',
                    child: FlareActor("assets/life.flr"
                      ,alignment: Alignment.bottomCenter,animation: widget.flare_animation,controller: widget.controls,),
                  )
                ),
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(370),
                ),

                Container(
                  width: double.infinity,
                  height: ScreenUtil.getInstance().setHeight(2000),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(/*topRight: Radius.circular(60.0),*/ topLeft: Radius.circular(70.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        HandleAQI()
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


}

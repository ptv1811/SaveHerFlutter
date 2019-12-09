import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomePage extends StatefulWidget {

  final FlareControls controls;

  const HomePage(
      {Key key,
        @required this.controls
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
                  height: ScreenUtil.getInstance().setHeight(450),
                  width: ScreenUtil.getInstance().setWidth(800),
                  child:Hero(
                    tag: 'fly',
                    child: FlareActor("assets/life.flr"
                      ,alignment: Alignment.bottomCenter,animation: "evening",controller: widget.controls,),
                  )
                ),
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(500),
                ),
                Container(
                  width: double.infinity,
                  height: ScreenUtil.getInstance().setHeight(500),
                  decoration: BoxDecoration(
                    color: Colors.white,
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

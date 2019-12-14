import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:save_her/Widget/SlideCart.dart';


class FeaturesPage extends StatefulWidget {



  @override
  _FeaturesPageState createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController animationController;


  final FlareControls controls = FlareControls();

  @override
  void initState() {
    super.initState();
    animationController= AnimationController(duration: Duration(seconds: 1),vsync: this);
    animation= Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticInOut
    ));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final double width= MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child){
        return Transform(
          transform: Matrix4.translationValues(animation.value*width,0.0,0.0),
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
                          alignment: Alignment.center,animation: "animation",controller: controls,),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 40.0),
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
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}

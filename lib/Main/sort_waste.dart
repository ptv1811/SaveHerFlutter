import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_swipe/Constants/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:save_her/Main/cameraview.dart';


class Classification extends StatefulWidget {
  @override
  _ClassificationState createState() => _ClassificationState();
}


class _ClassificationState extends State<Classification> {

  static FlareControls controls = FlareControls();

  @override
  Widget build(BuildContext context) {
    final pages=[
      Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Container(
                  width: ScreenUtil.getInstance().setWidth(800),
                  height: ScreenUtil.getInstance().setHeight(600),
                  child: FlareActor("assets/float.flr",animation: "float",alignment: Alignment.center,),

                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(20.0),
              ),
              Text("Welcome to waste sorting",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Avo",
                    fontSize: ScreenUtil.getInstance().setSp(50.0)
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(10.0),
              ),

              Padding(
                padding: EdgeInsets.all(50.0),
                child: Text("In order to save mother Earth, we are here to help you sorting different type of waste",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.getInstance().setSp(25),
                      fontFamily: "Avo",
                  ),
                  textAlign: TextAlign.center,

                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(50.0),
              ),
              
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text("Swipe left to try it now!",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Avo",
                  fontSize: ScreenUtil.getInstance().setSp(30)
                )),
              )


            ],
          )
      ),
      Container(
          width: double.infinity,
          height: double.infinity,
          child: CameraScreen()
      ),
    ];


    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        fullTransitionValue: 200,
        enableLoop: false,
        enableSlideIcon: true,
        positionSlideIcon: 0.8,
        slideIconWidget: Icon(Icons.arrow_back_ios,color: Colors.white,),
        waveType: WaveType.circularReveal,
        onPageChangeCallback: (pages)=> pageChangeCallback(pages),
        currentUpdateTypeCallback: (updatetype)=>updateTypeCallback(updatetype),

      ),
    );
  }

  pageChangeCallback(int page) {
    print(page);
  }

  updateTypeCallback(UpdateType updatetype) {
    print(updatetype);
  }
}

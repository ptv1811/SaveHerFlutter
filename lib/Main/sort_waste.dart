import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gooey_carousel/gooey_carrousel.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:save_her/Main/cameraview.dart';


class Classification extends StatefulWidget {
  @override
  _ClassificationState createState() => _ClassificationState();
}


class _ClassificationState extends State<Classification> {

  static FlareControls controls = FlareControls();

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
        color: Colors.green,
        width: double.infinity,
        height: double.infinity,
        child: CameraScreen()
    ),
  ];

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: GooeyCarousel(
       children: <Widget>[

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
             color: Colors.green,
             width: double.infinity,
             height: double.infinity,
             child: CameraScreen()
         ),


       ],

      ),
    );
  }

}
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flare_flutter/flare_controls.dart';

class StackFlare extends StatefulWidget {

  final FlareControls controls;

  const StackFlare(
      {Key key,
      @required this.controls
      }):super(key: key);

  @override
  _StackFlareState createState() => _StackFlareState();


}

class _StackFlareState extends State<StackFlare> {


  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(140),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Hero(
              tag: 'fly',
              child: new FlareActor("assets/life.flr"
                ,alignment: Alignment.bottomCenter,animation: "evening",controller: widget.controls,),
            )

          )
      ),
    );
  }
}

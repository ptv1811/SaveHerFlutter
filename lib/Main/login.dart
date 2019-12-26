import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/animation.dart';
import 'package:save_her/Widget/FormCard.dart';
import '../Widget/StackFlare.dart';
import '../Tools/HexColor.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController animationController;

  DateTime now;
  String _flare_animation;


  final FlareControls controls = FlareControls();

  static bool passwordvisible=true;
  static bool cpasswordvisible=true;
  int count=1;

  Color _background_color;


  @override
  void initState() {
    super.initState();
    animationController= AnimationController(duration: Duration(seconds: 1),vsync: this);
    animation= Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn
    ));
    animationController.forward();
    passwordvisible=true;
    cpasswordvisible=true;
    now= DateTime.now();
    if ( 6 < now.hour && now.hour<18){
      _flare_animation="morning";
      _background_color = HexColor("#dff8f8");

    }
    else{
      _flare_animation="evening";
      _background_color= HexColor("#0d2d41");
    }


  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child){
        return new Scaffold(
            backgroundColor: _background_color,
            resizeToAvoidBottomPadding: false,
            body:Stack(
                fit: StackFit.expand,
                children: <Widget>[

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height *0.45,
                            width: MediaQuery.of(context).size.width,
                            child: new FlareActor("assets/aaa.flr",alignment: Alignment.center,animation:_flare_animation,controller: controls,fit: BoxFit.contain,)
                        ),
                      ),

                     StackFlare(controls: controls,
                     flare_animation: _flare_animation,)
                    ],
                  ),
                  FormCard()
                ],
              ),
        );
      },
    );



  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}

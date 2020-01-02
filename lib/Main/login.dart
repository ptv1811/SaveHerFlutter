import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:save_her/Widget/FormCard.dart';
import '../Widget/StackFlare.dart';
import '../Tools/HexColor.dart';
import 'package:save_her/Main/homepage.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {

  DateTime now;
  String _flare_animation;

  final FirebaseAuth auth=FirebaseAuth.instance;

  Color _lower_color, _bottom_navigation_color;

  final FlareControls controls = FlareControls();

  static bool passwordvisible=true;
  static bool cpasswordvisible=true;
  int count=1;

  Color _background_color;


  @override
  void initState() {
    super.initState();
    passwordvisible=true;
    cpasswordvisible=true;
    now= DateTime.now();
    if ( 6 < now.hour && now.hour<18){
      _flare_animation="morning";
      _background_color = HexColor("#dff8f8");
      _lower_color= HexColor("#52877D");
      _bottom_navigation_color=HexColor("#b2e0e0");

    }
    else{
      _flare_animation="evening";
      _background_color= HexColor("#0d2d41");
      _lower_color=HexColor("#264E68");
      _bottom_navigation_color=HexColor("#98bcd3");
    }


    auth.currentUser().then((currentUser)=>{
      if (currentUser != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context)=> HomePage(
          controls: controls,
          flare_animation: _flare_animation,
          background_color: _background_color,
          low_color: _lower_color,
          bottom_navigation: _bottom_navigation_color,)))
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
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



  }

  @override
  void dispose() {
    super.dispose();
  }
}

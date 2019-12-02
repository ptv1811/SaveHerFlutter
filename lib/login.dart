import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FlareControls controls = FlareControls();
  void _playSuccessAnimation() {
    // Use the controls to trigger an animation.
    controls.play("spin");
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    final email=TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        labelText: "Email",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
    );

    final password=TextFormField(
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          labelText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );


    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Center(
                child: Container(
                    height: ScreenUtil.getInstance().setHeight(650),
                    width: ScreenUtil.getInstance().setWidth(800),
                    child: new FlareActor("assets/aaa.flr",alignment: Alignment.center,animation:"spin",controller: controls,fit: BoxFit.contain,)

                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0,right: 28.0,top: 60.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(350),
                  ),
                  Container(
                    width: double.infinity,
                    height: ScreenUtil.getInstance().setHeight(550),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0,15.0),
                          blurRadius: 15.0
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0,-10.0),
                          blurRadius: 10.0
                        ),
                      ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0,top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Save Her",
                            style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(45),
                              fontFamily: "Avo",
                              letterSpacing: .6,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          email,
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          password,

                        ],
                      ),
                    ),

                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

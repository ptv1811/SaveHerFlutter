import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_her/Widget/FormCard.dart';
import 'package:flutter/animation.dart';
import 'package:save_her/Widget/FormCardExpanded.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {

  Animation animation;
  AnimationController animationController;

  bool _isselected=true;
  Widget _widget= FormCard();
  final FlareControls controls = FlareControls();
  void _playSuccessAnimation() {
    // Use the controls to trigger an animation.
    controls.play("spin");
  }
  var _signin = 'Sign In';
  var _signup = 'Sign Up';

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(140),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  final email=TextFormField(
    obscureText: false,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        labelText: "Email",
        border: OutlineInputBorder(
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

  double _height= 350;
  int count=1;

  @override
  void initState() {
    super.initState();
    animationController= AnimationController(duration: Duration(seconds: 4),vsync: this);
    animation=IntTween(begin: 10, end: 0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut)
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);



    return new Scaffold(
      backgroundColor: Color(0xff99EAE1),
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
              padding: EdgeInsets.only(left: 28.0,right: 28.0,top: 45.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(_height),
                  ),

                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation){
                      return SizeTransition(child: child,sizeFactor: animation,axisAlignment: 0.001,);
                    },
                    child: _widget
                  ),

                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 50.0,
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                count+=1;
                                if (count % 2 ==0){
                                  _widget=FormCardExpanded();
                                  _height=300;
                                  _signup="Sign In";
                                  _signin="Sign Up";
                                }
                                else if (count %2 !=0){
                                  _widget=FormCard();
                                  _height=350;
                                  _signup="Sign Up";
                                  _signin="Sign In";
                                }
                              });

                            },
                            onDoubleTap: (){
                              setState(() {
                                _widget=FormCard();
                              });
                            },
                            child: Text(_signup,
                              style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(35),
                                fontFamily: "Avo"
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff00796C),
                                    Color(0xff66AEA6),
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12.withOpacity(.1),
                                    offset: Offset(0.0,8.0)

                                )
                              ]
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: (){},
                              child: Center(
                                child: Text(_signin,
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(35),
                                  fontFamily: "Avo",
                                  color: Colors.white,
                                ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Social Login",
                        style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(20),
                          fontFamily: "Avo",
                          color: Colors.black
                        ),

                      ),
                      horizontalLine()
                    ],
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

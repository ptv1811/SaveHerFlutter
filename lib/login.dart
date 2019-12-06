import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_her/Widget/FormCard.dart';
import 'package:flutter/animation.dart';
import 'package:save_her/Widget/ShowUp.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController animationController;


  final _emailcapture= TextEditingController();
  final _passwordcapture= TextEditingController();
  final _cpasswordcapture= TextEditingController();

  bool _isvisible=false;
  Widget _widget= new FormCard();
  final FlareControls controls = FlareControls();
  var _signin = 'Sign In';
  var _signup = 'Sign Up';
  static bool passwordvisible=true;
  static bool cpasswordvisible=true;

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(140),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  double _height=500;
  double _hofcontain=350;
  int count=1;


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
            backgroundColor: Color(0xff99EAE1),
            resizeToAvoidBottomPadding: true,
            body:Transform(
              transform: Matrix4.translationValues(animation.value *width, 0.0, 0.0),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Center(
                        child: Container(
                            height: ScreenUtil.getInstance().setHeight(600),
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
                            height: ScreenUtil.getInstance().setHeight(_hofcontain),
                          ),

                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: double.infinity,
                            height: ScreenUtil.getInstance().setHeight(_height),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0, right: 16.0,top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment(-0.81,0.0),
                                    child: Text("Save Her",
                                      style: TextStyle(
                                        fontSize: ScreenUtil.getInstance().setSp(55),
                                        fontFamily: "Avo",
                                        color: Colors.teal,
                                        letterSpacing: .6,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: ScreenUtil.getInstance().setHeight(30),
                                  ),

                                  TextFormField(
                                    controller: _emailcapture,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        labelText: "Email",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(32.0)
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  TextFormField(
                                    validator: (value){
                                      if (value.isEmpty){
                                        return "Password can not be empty!";
                                      }
                                      return null;
                                    },
                                    controller: _passwordcapture,
                                    obscureText: passwordvisible,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        labelText: "Password",
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            passwordvisible
                                                ? Icons.visibility : Icons.visibility_off,
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              passwordvisible=!passwordvisible;
                                            });
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(32.0)
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil.getInstance().setHeight(30),
                                  ),

                                  Visibility(
                                    visible: _isvisible,
                                    maintainAnimation: false,
                                    maintainSize: false,
                                    maintainState: true,

                                    child: TextFormField(
                                      controller: _cpasswordcapture,
                                      obscureText: cpasswordvisible,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(20),
                                          labelText: "Confirm password",
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              cpasswordvisible
                                                  ? Icons.visibility : Icons.visibility_off,
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                cpasswordvisible=!cpasswordvisible;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(32.0)
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                            _hofcontain=300;
                                            _height=600;
                                            _signup="Sign In";
                                            _signin="Sign Up";
                                            _isvisible=!_isvisible;
                                          }
                                          else if (count %2 !=0){
                                            _hofcontain=350;
                                            _height=500;
                                            _signup="Sign Up";
                                            _signin="Sign In";
                                            _isvisible=!_isvisible;
                                          }
                                        });

                                      },
                                      child: ShowUp(
                                        delay: 500,
                                        child: Text(_signup,
                                          style: TextStyle(
                                              fontSize: ScreenUtil.getInstance().setSp(35),
                                              fontFamily: "Avo"
                                          ),
                                        ),
                                      )

                                  )
                                ],
                              ),
                              SizedBox(
                                width: 45.0,
                              ),
                              InkWell(
                                onTap: () {

                                },

                                child: Container(
                                  width: ScreenUtil.getInstance().setWidth(330),
                                  height: ScreenUtil.getInstance().setHeight(100),
                                  decoration: BoxDecoration(
                                      color: Color(0xff00796C),
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
                                      onTap: (){
                                        String email, password;
                                        if (_isvisible==false){
                                          email=_emailcapture.text;
                                          password=_passwordcapture.text;
                                          FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
                                              password: password);
                                        }
                                        else if (_isvisible==true){
                                          email=_emailcapture.text;
                                          password=_passwordcapture.text;
                                          FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,
                                              password: password);
                                        }
                                      },
                                      child: Center(
                                        child: AnimatedDefaultTextStyle(
                                          duration: Duration(milliseconds: 200),
                                          style: TextStyle(
                                            fontSize: ScreenUtil.getInstance().setSp(35),
                                            fontFamily: "Avo",
                                            color: Colors.white,),
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
              ),
            )

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

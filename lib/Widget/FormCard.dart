import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ShowUp.dart';
import 'package:save_her/Main/homepage.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:save_her/Tools/HexColor.dart';
import 'package:save_her/Widget/AnimatedText.dart';


class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController animationController;

  final _emailcapture= TextEditingController();
  final _passwordcapture= TextEditingController();
  final _cpasswordcapture= TextEditingController();

  bool _isvisible=false;

  static var _signin = 'Sign In';
  var _signup = 'Sign Up';
  static bool passwordvisible=true;
  static bool cpasswordvisible=true;

  final FirebaseAuth auth=FirebaseAuth.instance;

  double _height=500;
  double _hofcontain=275;
  int count=1;
  double begin=1.0;
  double end=0.0;

  Color _background_color, _button_color, _string_color;
  Color _lower_color, _bottom_navigation_color;

  String _flare_animation;

  final FlareControls controls = FlareControls();

  DateTime now;
  @override
  void initState() {
    super.initState();

    animationController= AnimationController(duration: Duration(seconds: 1),vsync: this);
    animation= Tween(begin: begin,end: end).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn
    ));
    animationController.forward();

    now=DateTime.now();
    if ( 6 < now.hour && now.hour<18){
      _flare_animation="morning";
      _background_color = HexColor("#dff8f8");
      _button_color=HexColor("#0c716e");
      _string_color=HexColor("#000000");
      _lower_color= HexColor("#52877D");
      _bottom_navigation_color=HexColor("#b2e0e0");
    }
    else{
      _flare_animation="evening";
      _background_color= HexColor("#0d2d41");
      _button_color= HexColor("#407BA3");
      _string_color=HexColor("#ffffff");
      _lower_color=HexColor("#264E68");
      _bottom_navigation_color=HexColor("#98bcd3");
    }
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context,Widget child){
        return Transform(
            transform: Matrix4.translationValues(animation.value *width, 0.0, 0.0),
          child: SingleChildScrollView(
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
                    curve: Curves.easeInCirc,
                    height: ScreenUtil.getInstance().setHeight(_height),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
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
                          )
                        ]
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
                                color: _button_color,
                                letterSpacing: .6,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(40),
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
                              autofocus: false,
                              validator: (value)=> value.isEmpty ?"Confirm password cannot be empty":null,
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
                                    _hofcontain=225;
                                    _height=600;
                                    _signup="Sign In";
                                    _signin="Sign Up";
                                    _isvisible=!_isvisible;
                                  }
                                  else if (count %2 !=0){
                                    _hofcontain=275;
                                    _height=500;
                                    _signup="Sign Up";
                                    _signin="Sign In";
                                    _isvisible=!_isvisible;
                                  }
                                });

                              },
                              child: ShowUp(
                                delay: 500,
                                child: AnimatedText(text: _signup,
                                  style: TextStyle(
                                      color: _string_color,
                                      fontSize: ScreenUtil.getInstance().setSp(35),
                                      fontFamily: "Avo"
                                  ),
                                  textRotation: AnimatedTextRotation.up,
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
                              color: _button_color,
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
                                String email, password, c_password;
                                if (_isvisible==false){
                                  email=_emailcapture.text;
                                  password=_passwordcapture.text;

                                  if (email.isNotEmpty && password.isNotEmpty){

                                    signIn(email,password);
                                  }
                                  else _EmptyFieldDialog();
                                }
                                else if (_isvisible==true){
                                  email=_emailcapture.text;
                                  password=_passwordcapture.text;
                                  c_password=_cpasswordcapture.text;

                                  if (email.isNotEmpty && password.isNotEmpty && c_password.isNotEmpty){
                                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,
                                        password: password);
                                    FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
                                        password: password);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=> HomePage(
                                          controls: controls,
                                          flare_animation: _flare_animation,
                                          background_color: _background_color,
                                          low_color: _lower_color,
                                          bottom_navigation: _bottom_navigation_color,)
                                        )
                                    );
                                  }
                                  else{
                                    _SignUpDialog();
                                  }

                                }
                              },
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: Duration(milliseconds: 200),
                                  style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(35),
                                    fontFamily: "Avo",
                                    color: Colors.white,),
                                  child: AnimatedText(text: _signin,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _EmptyFieldDialog(){
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("Did you miss something?",
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(40),
            fontFamily: "Avo",
            color:_button_color
          ),
          ),
          content: new Text("Email/Password can't be empty!",
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(30),
            fontFamily: "Avo",
            color: Colors.black
          ),),
          actions: <Widget>[
            FlatButton(
              child: Text("Okay",
              style: TextStyle(
                fontFamily: "Avo",
                fontSize: ScreenUtil.getInstance().setSp(30),
                color: _button_color
              ),),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          )
        );
      }
    );
  }

  void _SignUpDialog(){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
              title: new Text("Something went wrong",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(40),
                    fontFamily: "Avo",
                    color:_button_color
                ),
              ),
              content: new Text("Please try again!",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(30),
                    fontFamily: "Avo",
                    color: Colors.black
                ),),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay",
                    style: TextStyle(
                        fontFamily: "Avo",
                        fontSize: ScreenUtil.getInstance().setSp(30),
                        color: _button_color
                    ),),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              )
          );
        }
    );
  }


  void _SignInFailedDialog(){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
              title: new Text("Oops",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(40),
                    fontFamily: "Avo",
                    color:_button_color
                ),
              ),
              content: new Text("Wrong username or password",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(30),
                    fontFamily: "Avo",
                    color: Colors.black
                ),),
              actions: <Widget>[
                FlatButton(
                  child: Text("Try again",
                    style: TextStyle(
                        fontFamily: "Avo",
                        fontSize: ScreenUtil.getInstance().setSp(30),
                        color: _button_color
                    ),),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              )
          );
        }
    );
  }

  void signIn(String email, String password) async{
    var user;

    try{
      user=await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e);
    }finally{
      if (user!=null){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> HomePage(
              controls: controls,
              flare_animation: _flare_animation,
              background_color: _background_color,
              low_color: _lower_color,
              bottom_navigation: _bottom_navigation_color,)
            )
        );
      }
      else{
        _SignInFailedDialog();
      }
    }
  }
}

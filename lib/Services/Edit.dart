import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_her/Main/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController animationController;

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
  void dispose() {
    super.dispose();
    animationController.dispose();
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
            padding: EdgeInsets.only(top: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                GestureDetector(
                  onTap: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login()));
                    setState(() {

                    });
                  },

                  child: Container(
                    width: ScreenUtil.getInstance().setWidth(500),
                    height: ScreenUtil.getInstance().setHeight(150),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                    child: Center(
                      child: Text("Sign Out",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenUtil.getInstance().setSp(30),
                            fontFamily: "Avo"
                        ),),
                    ),
                  ),
                )



              ],
            ),
          ),
        );
        }
    );
  }
}

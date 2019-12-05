import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCardExpanded extends StatefulWidget {
  @override
  _FormCardExpandedState createState() => _FormCardExpandedState();
}

class _FormCardExpandedState extends State<FormCardExpanded> {

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

  final cpassword=TextFormField(
    obscureText: false,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        labelText: "Confirm password",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0)
        )
    ),
  );

  double _height=600;


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
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

            email,
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            password,
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            cpassword,
          ],
        ),
      ),
    );
  }
}

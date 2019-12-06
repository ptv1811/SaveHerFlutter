import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();

}



class _FormCardState extends State<FormCard> {

  final _emailcontroller= TextEditingController();
  final _passwordcontroller= TextEditingController();

  static bool passwordvisible;
  double _height=500;



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


            TextFormField(
              controller: _emailcontroller,
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
              controller: _passwordcontroller,
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
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    passwordvisible= false;
  }
}


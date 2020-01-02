import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mlkit/mlkit.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:math';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController animationController;

  File image;
  int a=0;
  double height=150;
  double width=500;
  Color _color=Colors.red;

  List<String> Recyclable= ["Jewellery","Tableware","Porcelain","Paper"];
  List<String> Organic=["Vegetable","Bird","Fish","Fruit"];

  static String text;
  static String entityId;
  static String confidence;
  String assets;
  String advide;

  Widget _result;
  String type;

  Widget _widget= Container(
    key: ValueKey(1),
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
      child: Text("Analyze",
        style: TextStyle(
            color: Colors.red,
            fontSize: ScreenUtil.getInstance().setSp(30),
            fontFamily: "Avo"
        ),),
    ),
  );


  @override
  void initState() {
    super.initState();
    animationController= AnimationController(duration: Duration(seconds: 1),vsync: this);
    animation= Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn
    ));
    animationController.forward();
  }

  Future<String> get _localpath async{
    final directory= await getApplicationDocumentsDirectory();
    return directory.path;
  }


  _openGallery() async{
    File picture= await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image=picture;
    });


    // Navigator.pop(context);

  }

  _openCamera() async{
    File picture= await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      image=picture;
    });
    image= await image.copy("$_localpath/save_${a+=1}.jpg");


    //Navigator.pop(context);
  }


  Widget _decideView(){
    if (image==null){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(
            height: ScreenUtil.getInstance().setHeight(350),
          ),

          Text("Choose your method",
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil.getInstance().setSp(50),
                fontFamily: "Avo"
            ),
          ),

          SizedBox(
            height: ScreenUtil.getInstance().setHeight(100),
          ),
          InkWell(
              onTap: (){
                _openGallery();
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
                  child: Text("Choose image from gallery",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtil.getInstance().setSp(30),
                        fontFamily: "Avo"
                    ),),
                ),
              )
          ),

          SizedBox(
            height: ScreenUtil.getInstance().setHeight(30.0),
          ),

          InkWell(
              onTap: (){
                _openCamera();
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
                  child: Text("Take picture",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtil.getInstance().setSp(30),
                        fontFamily: "Avo"
                    ),),
                ),
              )
          )
        ],
      );
    }
    else {

      detectLabels().then((_){

      });

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(20),
          ),

          Container(
            width: ScreenUtil.getInstance().setWidth(500),
            height: ScreenUtil.getInstance().setHeight(700),

            child: Image.file(image,width: 400,height: 500,),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(0),
          ),

          InkWell(
            onTap: (){
              setState(() {

                for (int i=0; i< Recyclable.length;i++){
                  if (text==Recyclable[i]){
                    type="Recyclable";
                    assets="assets/image/recyclable.png";
                    _color=Colors.blue;
                    advide="You should throw it to the blue trash bin";
                  }
                }

                for (int i=0; i< Organic.length;i++){
                  if (text==Organic[i]){
                    type="Organic";
                    assets="assets/image/organic.png";
                    _color=Colors.green;
                    advide="You should throw it to the green trash bin";
                  }
                }
                _widget= Container(
                    key: ValueKey(2),
                    width: ScreenUtil.getInstance().setWidth(700),
                    height: ScreenUtil.getInstance().setHeight(520),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(15),
                        ),
                        Text("What we found in your image is",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Avo",
                              fontSize: ScreenUtil.getInstance().setSp(30.0)
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(10.0),
                        ),
                        Text("$text",
                          style: TextStyle(
                              color: _color,
                              fontSize: ScreenUtil.getInstance().setSp(40),
                              fontFamily: "Avo"
                          ),),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(1.0),
                        ),
                        Text("With the probability of",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Avo",
                              fontSize: ScreenUtil.getInstance().setSp(30.0)
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(10.0),
                        ),
                        Text("$confidence %",
                          style: TextStyle(
                              color: _color,
                              fontSize: ScreenUtil.getInstance().setSp(40),
                              fontFamily: "Avo"
                          ),),
                        Text("$type",
                          style: TextStyle(
                              color: _color,
                              fontFamily: "Avo",
                              fontSize: ScreenUtil.getInstance().setSp(50)
                          ),),

                        Text(advide,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Avo",
                              fontSize: ScreenUtil.getInstance().setSp(20)
                          ),),

                        Image.asset(assets,width: ScreenUtil.getInstance().setWidth(150),
                          height: ScreenUtil.getInstance().setHeight(150),)
                      ],
                    )
                );
              });


            },
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              transitionBuilder: (Widget child, Animation<double> animation)=>
                  ScaleTransition(child: child,scale: animation,),
              child: _widget,
            ),
          )





        ],
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.red
        ),
        child: _decideView()
    );
  }

  Future<void> detectLabels()async{
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    final List<ImageLabel> labels = await labeler.processImage(visionImage);

    for (ImageLabel label in labels) {

      text = label.text;
      entityId = label.entityId;
      confidence = (label.confidence*100).toStringAsFixed(1);
    }

    labeler.close();
  }


}
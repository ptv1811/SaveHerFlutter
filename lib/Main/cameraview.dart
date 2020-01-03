import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';
import 'dart:math';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController animationController;

  int a=0;
  double height=150;
  double width=500;
  Color _color=Colors.red;


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

  List _outputs;
  File _image;
  bool _loading = false;


  @override
  void initState() {
    super.initState();

    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });


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


  pickImageFromGal() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }


  _pickImageFromCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }


  Widget _decideView(){
    if (_image==null){
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
                pickImageFromGal();
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
                _pickImageFromCam();
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


      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(20),
          ),

          Container(
            width: ScreenUtil.getInstance().setWidth(500),
            height: ScreenUtil.getInstance().setHeight(700),

            child: Image.file(_image,width: 400,height: 500,),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(0),
          ),

          InkWell(
            onTap: (){
              setState(() {


                  if (_outputs[0]["label"].toString()=="1 Recyclable"){
                    type="Recyclable";
                    assets="assets/image/recyclable.png";
                    _color=Colors.blue;
                    advide="You should throw it to the blue trash bin";
                  }


                  if (_outputs[0]["label"].toString()=="0 Organic"){
                    type="Organic";
                    assets="assets/image/organic.png";
                    _color=Colors.green;
                    advide="You should throw it to the green trash bin";
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
                        Text("${_outputs[0]["confidence"]*100} %",
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

                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(20.0),
                        ),

                        Text(advide,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Avo",
                              fontSize: ScreenUtil.getInstance().setSp(30)
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
    return Scaffold(
      body: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeOut,
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: _color
          ),
          child: _decideView()
      ),
    );
  }

  @override
  void dispose() {
    Tflite.close();
    animationController.dispose();
    super.dispose();
  }

}
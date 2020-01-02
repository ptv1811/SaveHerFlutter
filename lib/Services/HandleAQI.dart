import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:save_her/Main/air_aqi.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class HandleAQI extends StatefulWidget {
  @override
  _HandleAQIState createState() => _HandleAQIState();
}

class _HandleAQIState extends State<HandleAQI> {
  Future<AQI> fetchAQI() async{


    final response=
    await http.get('http://api.airvisual.com/v2/city?city=Ho Chi Minh City&state=Ho Chi Minh City&country=Vietnam&key=ae114a29-b270-4823-8ddc-eb83fb0833d9');

    if(response.statusCode== 200){
      debugPrint(response.body);


      return AQI.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Failed');
    }
  }



  Future<AQI> aqi;
  String _path, _weather;

  @override
  void initState() {
    super.initState();
    aqi=fetchAQI();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        height: ScreenUtil.getInstance().setHeight(200),
        width: ScreenUtil.getInstance().setWidth(370),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
        child: FutureBuilder<AQI>(
          future: aqi,
          builder: (context,snapshot){

            if (snapshot.hasData){
              if(snapshot.data.data.current.pollution.aqius >=0 && snapshot.data.data.current.pollution.aqius<=50)
                _path="assets/icons/good.png";
              else if (snapshot.data.data.current.pollution.aqius >=51 && snapshot.data.data.current.pollution.aqius<=100)
                _path="assets/icons/moderate.png";
              else if (snapshot.data.data.current.pollution.aqius >=101 && snapshot.data.data.current.pollution.aqius<=150)
                _path="assets/icons/unhealthy_for_so.png";
              else if (snapshot.data.data.current.pollution.aqius >=151 && snapshot.data.data.current.pollution.aqius<=200)
                _path="assets/icons/unhealthy.png";
              else if (snapshot.data.data.current.pollution.aqius >=201 && snapshot.data.data.current.pollution.aqius<=300)
                _path="assets/icons/very_unhealthy.png";
              else if (snapshot.data.data.current.pollution.aqius > 300)
                _path="assets/icons/hazard.png";

              _weather= "assets/weather/${snapshot.data.data.current.weather.ic}.png";


              return Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      fit: StackFit.loose,
                      children: <Widget>[
                        Image.asset(_path,
                          width: 60,
                          height: 100,
                        ),

                        Positioned(
                          top: 45,
                          left: 15,
                          child: Text("${snapshot.data.data.current.pollution.aqius}",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Avo",
                              fontSize: ScreenUtil.getInstance().setSp(40)
                            ),
                          ),
                        ),
                        
                        Positioned(
                          top: 70,
                          left: 18,
                          child: Text("AQI",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontFamily: "Avo",
                            color: Colors.black,
                            fontSize: ScreenUtil.getInstance().setSp(20)
                          ),),
                        )


                      ],
                    ),

                    SizedBox(
                      width: 10,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(20.0),
                        ),
                          
                          Text("${snapshot.data.data.city}",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Avo"
                            ),
                          ),

                          Text("${snapshot.data.data.country}",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Avo",
                              fontSize: ScreenUtil.getInstance().setSp(22.0),
                            ),
                          ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(15.0) ,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.asset(_weather,
                            width: ScreenUtil.getInstance().setWidth(80.0),
                            height: ScreenUtil.getInstance().setHeight(70.0),
                            ),
                            SizedBox(
                              width: ScreenUtil.getInstance().setWidth(20.0),
                            ),
                            Text("${snapshot.data.data.current.weather.tp}°C",
                            style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(35.0),
                              fontFamily: "Avo",
                              color: Colors.black,
                            ),)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
          }
            else if (snapshot.hasError)
              return Text("${snapshot.error}");


            return Center(
              child: SpinKitCubeGrid(color: Colors.blue,),
            );

        },
      )
    );
  }
}

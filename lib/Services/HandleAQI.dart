import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:save_her/Main/air_aqi.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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

  @override
  void initState() {
    super.initState();
    aqi=fetchAQI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(200),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0,15.0),
                blurRadius: 15.0
            ),]
      ),
      child: FutureBuilder<AQI>(
        future: aqi,
        builder: (context,snapshot){
          if (snapshot.hasData){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
              ],

            );
          }
          else if (snapshot.hasError)
            return Text("${snapshot.error}");

          return CircularProgressIndicator();
        },
      )
    );
  }
}

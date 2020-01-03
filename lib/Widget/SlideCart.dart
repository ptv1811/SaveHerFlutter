import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:page_transition/page_transition.dart';
import 'package:save_her/Main/sort_waste.dart';
import 'package:save_her/Main/cameraview.dart';

class SlidingCardViews extends StatefulWidget {
  @override
  _SlidingCardViewsState createState() => _SlidingCardViewsState();
}

class _SlidingCardViewsState extends State<SlidingCardViews> {

  PageController _pageController;
  double pageOffset=0;


  @override
  void initState() {
    super.initState();
    _pageController= PageController(viewportFraction: 0.8);
    _pageController.addListener((){
      setState(() {
        pageOffset=_pageController.page;
      });
    });

  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.4,
      child: PageView(
        controller: _pageController,
        children: <Widget>[

          GestureDetector(
            child: SlidingCard(
              name: "Waste Classifcation",
              description: "Help you sort type of waste.",
              asset: "assets/image/waste.jpg",
              offset: pageOffset,
            ),
            onTap: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.downToUp,child: Classification()));

            },
          )
          ,
          SlidingCard(
            name: "Nearest Trash Bin",
            description: "Coming soon",
            asset: "assets/image/neareast.jpg",
            offset: pageOffset-1,
          )
        ],
      ),
    );
  }
}


class SlidingCard extends StatelessWidget {

  final String name;
  final String description;
  final String asset;
  final double offset;
  const SlidingCard({
    Key key,
    @required this.name,
    @required this.description,
    @required this.asset,
    @required this.offset
}):super(key: key);


  @override
  Widget build(BuildContext context) {

    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 30,right: 30,bottom: 24),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
              child: Image.asset(asset,
                height: MediaQuery.of(context).size.height*0.25,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: CardContent(name: name, description: description
              ,offset: gauss,),
            )
          ],
        ),
      ),)
    ;
  }
}

class CardContent extends StatelessWidget {

  final String name;
  final String description;
  final double offset;

  const CardContent({
    Key key, @required this.name, @required this.description,@required this.offset
}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Transform.translate(offset: Offset(8 * offset, 0),
          child: Text(name,
            style: TextStyle(fontSize: 25,
                color: Colors.black),
          ),
          ),
          SizedBox(
            height: 8,
          ),


          Transform.translate(offset: Offset(32 * offset, 0),
          child: Text(description,
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey),
          ),
          ),
        ],
      ),
    );
  }
}



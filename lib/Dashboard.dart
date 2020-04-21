import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:utility_app/Utilities_screens/weight_converter.dart';
import 'package:utility_app/Utilities_screens/bmi.dart';
import 'package:utility_app/Utilities_screens/temperature.dart';
import 'package:utility_app/Utilities_screens/length.dart';
import 'package:utility_app/Utilities_screens/calculator.dart';
import 'package:utility_app/Utilities_screens/age.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Utility Zone',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.lightBlue,Colors.pink.withOpacity(0.6) ,Colors.white])),
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: <Widget>[
              myitems(FontAwesomeIcons.calculator, 'Calculator', 0xffed622b,Calculator()),
              myitems(Icons.accessibility, 'BMI', 0xff26cb3c,BMI()),
              myitems(FontAwesomeIcons.weight, 'Weight', 0xffff3266,WeightConverter()),
              myitems(FontAwesomeIcons.temperatureLow, 'Temperature', 0xff3399fe,TempConverter()),
              myitems(FontAwesomeIcons.ruler, 'Length', 0xfff4c83f,Length()),
              myitems(Icons.cake, 'Age', 0xff622F74,Age()),
            ],
            staggeredTiles: [
              StaggeredTile.extent(tilecol(), randnumber()),
              StaggeredTile.extent(tilecol(), randnumber()),
              StaggeredTile.extent(tilecol(), randnumber()),
              StaggeredTile.extent(1, randnumber()),
              StaggeredTile.extent(1, randnumber()),
              StaggeredTile.extent(2, randnumber()),
            ],
          ),
        ));
  }

  Material myitems(IconData, String heading, int color,function) {
    return Material(
        color: Colors.white,
        elevation: 15.0,
        shadowColor: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20.0),
        child: InkResponse(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>function));
          },
          highlightColor: new Color(color).withOpacity(0.3),
          splashColor: new Color(color).withOpacity(0.3),
          radius: 40.0,
          containedInkWell: false,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            heading,
                            style: TextStyle(
                              color: new Color(color),
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: new Color(color),
                        borderRadius: BorderRadius.circular(20.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            IconData,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  double randnumber() {
    int min = 120;
    int max = 230;
    int selec = min + (Random().nextInt(max - min));
    double sele = selec + 0.1;
    return sele;
  }

  int tilecol() {
    return 1 + Random().nextInt(2);
  }


}

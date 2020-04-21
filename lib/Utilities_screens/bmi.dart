import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BMI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BMIState();
  }
}

class BMIState extends State<BMI> with SingleTickerProviderStateMixin {
  var height_choices = ['m', 'cm', 'inch', 'feet'];
  var current_height = 'cm';
  var weight_choices = ['kg', 'lbs', 'g'];
  var current_weight = 'kg';
  String displayresult_bmi = '0.0';
  Color color_for_result = Colors.blueGrey;
  String status = 'Status';

  TextEditingController height_controller = TextEditingController();
  TextEditingController weight_controller = TextEditingController();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 80),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.4,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 + _animationController.value;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'BMI Calculator',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            //stops: [0.2,0.3,1],
            colors: [
              Colors.white,
              Colors.lightBlue.withOpacity(0.6),
              Colors.purple.withOpacity(0.5)
            ],
          )),
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ListView(children: <Widget>[
                //first element of three fields
                Padding(
                    padding: EdgeInsets.only(top: 40.0, left: 15.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          'Height',
                          style: TextStyle(
                            fontSize: 27.0,
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: TextFormField(
                          controller: height_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Height',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: DropdownButton(
                              isExpanded: true,
                              items: height_choices
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                              elevation: 5,
                              value: current_height,
                              onChanged: (String valueSelectedByUser) {
                                setState(() {
                                  debugPrint(
                                      'User selected $valueSelectedByUser');
                                  this.current_height = valueSelectedByUser;
                                });
                              }),
                        ),
                      )
                    ])),

                //Second elemnet of weight with 3 elements

                Padding(
                    padding: EdgeInsets.only(top: 40.0, left: 15.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          'Weight',
                          style: TextStyle(fontSize: 27.0),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: TextFormField(
                          controller: weight_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Weight',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: DropdownButton(
                              isExpanded: true,
                              items: weight_choices
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                              elevation: 5,
                              value: current_weight,
                              onChanged: (String valueSelectedByUser) {
                                setState(() {
                                  debugPrint(
                                      'User selected $valueSelectedByUser');
                                  this.current_weight = valueSelectedByUser;
                                });
                              }),
                        ),
                      )
                    ])),
                Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, left: 55.0, right: 55.0,bottom: 20.0),
                    child: SizedBox(
                        height: 60,
                        width: 70,
                        child: GestureDetector(
                            onTapDown: OnTapDown,
                            onTapUp: OnTapUp,
                            onTapCancel: OnTapCancel,
                            child: Transform.scale(
                              scale: scale,
                              child: RaisedButton(
                                color: Colors.greenAccent.withOpacity(0.9),
                                elevation: 7.0,
                                child: Text(
                                  'Check BMI',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  textScaleFactor: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                    side: BorderSide(color: Colors.green)),
                                onPressed: () {
                                  setState(() {
                                    List temp = bmicalculator();
                                    displayresult_bmi = temp[0];
                                    color_for_result = temp[1];
                                    status = temp[2];
                                    debugPrint("Convert button clicked again ");
                                  });
                                },
                              ),
                            )))),
                          Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                          child: Row(
                          children: <Widget>[
                          Expanded(
                          child: Container(
                          child: Material(
                          color: Colors.white,
                          elevation: 15.0,
                          shadowColor: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(28.0),
                          child: InkResponse(
                         // highlightColor: Colors.red.withOpacity(0.3),
                          //splashColor: Colors.redAccent.withOpacity(0.3),
                          //radius: 40.0,
                          containedInkWell: false,
                          child: Center(
                          child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                             padding:
                             const EdgeInsets.all(5.0),
                              child: Text(
                              '$displayresult_bmi',
                          style: TextStyle(
                          color: color_for_result,
                          fontSize: 70.0,
                          ),
                          ),
                          ),
                          Center(
                          child: Column(
                          children: <Widget>[
                          Padding(
                          padding:
                          const EdgeInsets.all(
                          8.0),
                          child: Text(
                          'BMI ',
                          style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30.0,
                          fontWeight:
                          FontWeight.normal,
                          ),
                          ),
                          ),
                          Text('$status',
                          style: TextStyle(
                          color: color_for_result,fontSize: 20.0
                          ))
                          ],
                          ),
                          ),

                          ],
                          ),

                          ),
                          ),
                          )))),
              ])),
        ),
               // ImageMoney(),
              ]))));
  }

  OnTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  OnTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  OnTapCancel() {
    _animationController.reverse();
  }

  List bmicalculator(){
    double bmi = 0;
    String result = '';
    String status = '';
    Color color;
    double h = double.parse(height_controller.text);
    double w = double.parse(weight_controller.text);
    //convert height in meter
    if(this.current_height=='inch'){h = h*0.0254;}
    else if(this.current_height=='feet'){h = h*0.3048;}
    else if(this.current_height=='cm'){h = h*0.01;}

    //convert weight into kg
    if(this.current_weight == 'lbs'){w = w*0.453592;}
    else if(this.current_weight == 'g'){w = w*0.001;}

    bmi = w/(h*h);
    bmi = num.parse(bmi.toStringAsFixed(1));
    if(bmi<18.5){
      color = Colors.blueAccent;
      status = 'Underweight';
    }
    else if(18.5<=bmi && bmi<= 24.9){
      color = Colors.lightGreen;
      status = 'Healthy';
    }
    else if(25<=bmi && bmi<= 29.9){
      color = Colors.yellow;
      status =  'OverWeight';
    }
    else if(30<=bmi){
      color = Colors.red;
      status = 'Obese';
    }
    result = '$bmi';
    return [result,color,status];
  }
  Widget ImageMoney() {
    AssetImage im = AssetImage('images/BMI-Chart.jpg');
    Image image = Image(
      image: im,
      width: 200,
      height: 200,
    );
    return Container(
      child: image,
      margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 40.0,bottom: 20.0),
    );
  }

}


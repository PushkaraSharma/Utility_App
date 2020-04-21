import 'package:flutter/material.dart';

class TempConverter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TempConverterState();
  }
}

class TempConverterState extends State<TempConverter>
    with SingleTickerProviderStateMixin {
  var temperature_choices = ['Celsius', 'Fahrenheit', 'Kelvin'];
  var current_first_temp = 'Celsius';
  var current_second_temp = 'Fahrenheit';
  String displayresults = 'Convert';

  TextEditingController temp = TextEditingController();
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
            'Temperature Converter',
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
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                //first element of two fields
                Padding(
                  padding: EdgeInsets.only(top: 80.0, left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: temp,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Temperature',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: DropdownButton(
                              items: temperature_choices
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              elevation: 5,
                              value: current_first_temp,
                              onChanged: (String valueSelectedByUser) {
                                setState(() {
                                  debugPrint(
                                      'User selected $valueSelectedByUser');
                                  this.current_first_temp = valueSelectedByUser;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                ),
                //Second element Button
                Padding(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 35.0, right: 35.0),
                    child: SizedBox(
                        height: 70,
                        width: 40,
                        child: GestureDetector(
                            onTapDown: OnTapDown,
                            onTapUp: OnTapUp,
                            onTapCancel: OnTapCancel,
                            child: Transform.scale(
                              scale: scale,
                              child: RaisedButton(
                                color: Colors.deepOrange.withOpacity(0.9),
                                elevation: 7.0,
                                //color: Theme.of(context).primaryColorDark,
                                //textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  'Convert',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  textScaleFactor: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                    side: BorderSide(
                                        color: Colors.deepOrange
                                            .withOpacity(0.8))),
                                onPressed: () {
                                  setState(() {
                                    debugPrint("Convert button clicked");
                                    this.displayresults = calculations();
                                    debugPrint(
                                        "Convert button clicked again $displayresults");
                                  });
                                },
                              ),
                            )))),
                //Third element
                Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 180, height: 58,
                        //padding: EdgeInsets.all(20.0),
                        child: Center(
                            child: Text(
                          displayresults,
                          style: TextStyle(fontSize: 20.0),
                        )),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(5.0))),
                      ),
                      Container(
                        width: 15.0,
                      ),
                      Expanded(
                        child: ListTile(
                          title: DropdownButton(
                              items: temperature_choices
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              value: current_second_temp,
                              elevation: 5,
                              onChanged: (String valueSelectedByUser) {
                                setState(() {
                                  debugPrint(
                                      'User selected $valueSelectedByUser');
                                  this.current_second_temp =
                                      valueSelectedByUser;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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

  String calculations() {
    String rel = '';
    double tem = 0;
    double p = double.parse(temp.text);
    if(p==null){
      alertmsg('Alert!!','Please Provide Input');
    }
    if (this.current_first_temp == 'Celsius') {
      if (this.current_second_temp == 'Celsius') {
        tem = p;
      }
      if (this.current_second_temp == 'Fahrenheit') {
        tem = (p * 9 / 5) + 32;
      }
      if (this.current_second_temp == 'Kelvin') {
        tem = p + 273.15;
      }
    }
    if (this.current_first_temp == 'Fahrenheit') {
      if (this.current_second_temp == 'Celsius') {
        tem = (p - 32) * 5 / 9;
      }
      if (this.current_second_temp == 'Fahrenheit') {
        tem = p;
      }
      if (this.current_second_temp == 'Kelvin') {
        tem = (p + 459.67) * 5 / 9;
      }
    }
    if (this.current_first_temp == 'Kelvin') {
      if (this.current_second_temp == 'Celsius') {
        tem = p - 273.15;
      }
      if (this.current_second_temp == 'Fahrenheit') {
        tem = (p * 9 / 5) - 459.67;
      }
      if (this.current_second_temp == 'Kelvin') {
        tem = p;
      }
    }
    tem = num.parse(tem.toStringAsFixed(5));
    rel = '$tem';
    return rel;
  }
  void alertmsg(String title,String msg){
    AlertDialog al = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context,builder: (_)=>al);
  }
}

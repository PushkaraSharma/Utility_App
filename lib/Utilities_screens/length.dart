import 'package:flutter/material.dart';

class Length extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LengthState();
  }
}

class LengthState extends State<Length> with SingleTickerProviderStateMixin {
  var length_choices = [
    'Kilometer',
    'Meter',
    'Decimeter',
    'Centimeter',
    'Millimeter',
    'Micrometer',
    'Mile',
    'Yard',
    'Foot',
    'Inch',
    'Light year'
  ];
  var current_first_length = 'Kilometer';
  var current_second_length = 'Mile';
  String displayresults = 'Convert';

  TextEditingController length = TextEditingController();
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
            'Length Converter',
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
              Colors.purple.withOpacity(0.5),
              Colors.pink.withOpacity(0.6),
              Colors.red.withOpacity(0.6)
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
                        child: TextField(textAlign: TextAlign.center,
                          controller: length,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Length',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: DropdownButton(
                              items: length_choices
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              elevation: 5,
                              value: current_first_length,
                              onChanged: (String valueSelectedByUser) {
                                setState(() {
                                  debugPrint(
                                      'User selected $valueSelectedByUser');
                                  this.current_first_length =
                                      valueSelectedByUser;
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
                                color: Colors.pink.withOpacity(0.9),
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
                                        color: Colors.pinkAccent)),
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
                        width: 170, height: 58,
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
                      //Container(
                      //  width: 15.0,
                     // ),
                      Expanded(
                        child: ListTile(
                          title: DropdownButton(
                            isExpanded: true,
                              items: length_choices
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              value: current_second_length,
                              elevation: 5,
                              onChanged: (String valueSelectedByUser) {
                                setState(() {
                                  debugPrint(
                                      'User selected $valueSelectedByUser');
                                  this.current_second_length =
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
    double temp_wc = 0;
    double temp_wc_2 = 0;
    double p = double.parse(length.text);
    if(p==null){
      alertmsg('Alert!!','Please Provide Input');
    }

    //convert first length into meter
    debugPrint('$current_first_length,$current_second_length,$p');
    if (current_first_length == 'Kilometer') {
      temp_wc = p * 1000;
    }
    if (current_first_length == 'Meter') {
      temp_wc = p;
    }
    if (current_first_length == 'Decimeter') {
      temp_wc = p * 0.1;
    }
    if (current_first_length == 'Centimeter') {
      temp_wc = p * 0.01;
    }
    if (current_first_length == 'Millimeter') {
      temp_wc = p * 0.001;
    }
    if (current_first_length == 'Micrometer') {
      temp_wc = p / 1000000;
    }
    if (current_first_length == 'Mile') {
      temp_wc = p * 1609.344;
    }
    if (current_first_length == 'Yard') {
      temp_wc = p * 0.9144;
    }
    if (current_first_length == 'Foot') {
      temp_wc = p * 0.3048;
    }
    if (current_first_length == 'Inch') {
      temp_wc = p * 0.0254;
    }
    if (current_first_length == 'Light year') {
      temp_wc = p * 9461000000000000;
    }

    //convert meter into second length
    if (current_second_length == 'Kilometer') {
      temp_wc_2 = temp_wc * 0.001;
    }
    if (current_second_length == 'Meter') {
      temp_wc_2 = temp_wc;
    }
    if (current_second_length == 'Decimeter') {
      temp_wc_2 = temp_wc * 10;
    }
    if (current_second_length == 'Centimeter') {
      temp_wc_2 = temp_wc * 100;
    }
    if (current_second_length == 'Millimeter') {
      temp_wc_2 = temp_wc * 1000;
    }
    if (current_second_length == 'Micrometer') {
      temp_wc_2 = temp_wc * 1000000;
    }
    if (current_second_length == 'Mile') {
      temp_wc_2 = temp_wc * 0.00062137;
    }
    if (current_second_length == 'Yard') {
      temp_wc_2 = temp_wc * 1.09361;
    }
    if (current_second_length == 'Foot') {
      temp_wc_2 = temp_wc * 3.2808399;
    }
    if (current_second_length == 'Inch') {
      temp_wc_2 = temp_wc * 39.37;
    }
    if (current_second_length == 'Light year') {
      temp_wc_2 = temp_wc * 10570000000000000;
    }
    temp_wc_2 = num.parse(temp_wc_2.toStringAsFixed(5));
    rel = '$temp_wc_2';
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

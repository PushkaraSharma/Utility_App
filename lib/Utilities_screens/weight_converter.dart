import 'package:flutter/material.dart';

class WeightConverter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeightConverterState();
  }
}

class WeightConverterState extends State<WeightConverter>
    with SingleTickerProviderStateMixin {
  var weight_choices = ['Kilogram', 'Gram', 'Pound','Ton','Ounce','Carat','Quintal'];
  var current_first_weight = 'Kilogram';
  var current_second_weight = 'Pound';
  String displayresults = 'Convert';

  TextEditingController weight = TextEditingController();
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
            'Weight Converter',
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
                  Colors.purpleAccent,
                  Colors.pinkAccent.withOpacity(0.6),
                  Colors.redAccent.withOpacity(0.5)
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
                          controller: weight,
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
                              items: weight_choices
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              elevation: 5,
                              value: current_first_weight,
                              onChanged: (String valueSelectedByUser) {
                                setState(() {
                                  debugPrint(
                                      'User selected $valueSelectedByUser');
                                  this.current_first_weight = valueSelectedByUser;
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
                                color: Colors.lightBlue.withOpacity(0.8),
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
                                        color: Colors.lightBlue
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
                              items: weight_choices
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              value: current_second_weight,
                              elevation: 5,
                              onChanged: (String valueSelectedByUser) {
                                setState(() {
                                  debugPrint(
                                      'User selected $valueSelectedByUser');
                                  this.current_second_weight =
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
    double temp_wc_2  = 0;
    double p = double.parse(weight.text);
    if(p==null){
      alertmsg('Alert!!','Please Provide Input');
    }
    //convert first weight into kg
    debugPrint('$current_first_weight,$current_second_weight,$p');
    if(current_first_weight == 'Kilogram'){temp_wc=p;}
    if(this.current_first_weight == 'Gram'){temp_wc= p/1000;}
    if(this.current_first_weight == 'Pound'){temp_wc= p/2.204622;}
    if(this.current_first_weight == 'Ton'){temp_wc= p*1000;}
    if(this.current_first_weight == 'Ounce'){temp_wc= p*0.0283495;}
    if(this.current_first_weight == 'Carat'){temp_wc= p*0.0002;}
    if(this.current_first_weight == 'Quintal'){temp_wc= p*100;}
    //debugPrint('$temp_wc');
    //convert kg into second given weight
    if(this.current_second_weight == 'Kilogram'){temp_wc_2= temp_wc;}
    if(this.current_second_weight == 'Gram'){temp_wc_2 = temp_wc*1000;}
    if(this.current_second_weight == 'Pound'){temp_wc_2 = temp_wc*2.204622;}
    if(this.current_second_weight == 'Ton'){temp_wc_2 = temp_wc*0.001;}
    if(this.current_second_weight == 'Ounce'){temp_wc_2 = temp_wc*35.2739619;}
    if(this.current_second_weight == 'Carat'){temp_wc_2 = temp_wc*5000;}
    if(this.current_second_weight == 'Quintal'){temp_wc_2 = temp_wc*0.01;}
    //debugPrint('$temp_wc_2');
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


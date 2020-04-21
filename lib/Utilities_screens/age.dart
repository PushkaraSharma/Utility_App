import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';

class Age extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AgeState();
  }
}

class AgeState extends State<Age>with SingleTickerProviderStateMixin {
  DateTime selectedDate = new DateTime.now();
  DateTime selectedDate2 = new DateTime.now();

  var total_days = 0;
  var total_hrs = 0;
  var total_mins = 0;
  var total_weeks = 0;
  var total_months = 0;
  var age_yrs = 0;
  var next_b_months = 0;
  var next_b_days = 0;
  var age_weeks = 0;
  var age_days = 0;

  TextEditingController _date = new TextEditingController();
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
          'Age Fun',
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
        Colors.pink.withOpacity(0.5),
        Colors.lightBlue.withOpacity(0.6),
        Colors.purple.withOpacity(0.5)
        ],
        )),
        child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 30.0, bottom: 40.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Date of Birth',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  width: 30.0,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _date,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          hintText: 'Date of Birth',
                          prefixIcon: Icon(
                            Icons.date_range,
                            color: Colors.black,
                          )),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: 15.0, left: 30.0, right: 30.0, bottom: 20.0),
              child: SizedBox(
                width: 210,
                height: 70,
                child:GestureDetector(
                  onTapDown: OnTapDown,
                  onTapUp: OnTapUp,
                  onTapCancel: OnTapCancel,
                  child: Transform.scale(
                  scale: scale,
                  child:RaisedButton(
                  color: Colors.deepOrange.withOpacity(0.7),
                  elevation: 7.0,
                  //color: Theme.of(context).primaryColorDark,
                  //textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    'Check',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    textScaleFactor: 2,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      side: BorderSide(
                          color: Colors.deepOrange.withOpacity(0.8))),
                  onPressed: () {
                    setState(() {
                      datediff();
                    });

                    debugPrint('PRint');
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
                              borderRadius: BorderRadius.circular(20.0),
                              child: InkResponse(
                                highlightColor: Colors.red.withOpacity(0.3),
                                splashColor: Colors.redAccent.withOpacity(0.3),
                                radius: 40.0,
                                containedInkWell: false,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Age',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 25.0,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '$age_yrs ',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 45.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  Text('yrs',
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '$age_weeks weeks| $age_days days',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )))),
                  Container(
                    width: 8.0,
                  ),
                  Expanded(
                      child: Container(
                          child: Material(
                              color: Colors.white,
                              elevation: 15.0,
                              shadowColor: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(20.0),
                              child: InkResponse(
                                highlightColor: Colors.red.withOpacity(0.3),
                                splashColor: Colors.redAccent.withOpacity(0.3),
                                radius: 40.0,
                                containedInkWell: false,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Next Birthday',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 25.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              color: Colors.lightBlue
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Icon(
                                                  Icons.cake,
                                                  color: Colors.red,
                                                  size: 30.0,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top:14.0,left: 8.0,right:8.0,bottom:8.0),
                                                child: Text(
                                                  '$next_b_months months|$next_b_days days',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))))
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),
              child: Container(
                  child: Material(
                      color: Colors.white,
                      elevation: 15.0,
                      shadowColor: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20.0),
                      child: InkResponse(
                        highlightColor: Colors.red.withOpacity(0.3),
                        splashColor: Colors.redAccent.withOpacity(0.3),
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
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'Total Summary',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 25.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '$age_yrs',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 24.0,
                                                  ),
                                                ),
                                                Text(
                                                  'Years',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '$total_months',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 24.0,
                                                  ),
                                                ),
                                                Text(
                                                  'Months',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '$total_weeks',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 24.0,
                                                  ),
                                                ),
                                                Text(
                                                  'Weeks',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 20.0,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              '$total_days '
                                              'Days',
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              '$total_hrs Hours',
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              '$total_mins Mins',
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))))
        ],
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String convertedDate = new DateFormat.yMMMd().format(selectedDate);
        _date.value = TextEditingValue(text: convertedDate.toString());
        debugPrint('$convertedDate');
      });
  }

  int datediff() {
    total_days = selectedDate2.difference(selectedDate).inDays;
    total_hrs = selectedDate2.difference(selectedDate).inHours;
    total_mins = selectedDate2.difference(selectedDate).inMinutes;
    total_months = ((total_days/365)*12).toInt();
    total_weeks = (total_days / 7).toInt();
    age_yrs = (total_days / 365).toInt();
    age_weeks = ((total_days % 365) / 7).toInt();
    age_days = ((total_days % 365) % 7).toInt();
    var nxtby = 0;

    var m = int.parse(new DateFormat.M().format(selectedDate));
    var d = int.parse(new DateFormat.d().format(selectedDate));
    var tm = int.parse(new DateFormat.M().format(selectedDate2));
    var td = int.parse(new DateFormat.d().format(selectedDate2));
    var ty = int.parse(new DateFormat.y().format(selectedDate2));

    if(tm == m && td>=d || tm>m){ nxtby = ty+1;}
    else{ nxtby = ty;}

    DateTime nextBDate = new DateTime(nxtby,m,d);
    var NextBday_totalDays_diff = nextBDate.difference(selectedDate2).inDays;
    next_b_months = (NextBday_totalDays_diff/30).toInt();
    next_b_days =  (NextBday_totalDays_diff%30).toInt();
    debugPrint(
        '$total_days , $total_hrs , $total_mins ,$total_weeks ,$age_yrs , $age_weeks , $age_days');
  }
}

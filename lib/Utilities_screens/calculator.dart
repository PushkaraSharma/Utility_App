import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalculatorState();
  }
}

class CalculatorState extends State<Calculator> {
  String eq = '0';
  String result = '0';
  String expression = '';
  double eqfontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        eq = '0';
        result = '0';
        eqfontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == '⌫') {
        eq = eq.substring(0, eq.length - 1);
        if (eq == '') {
          eq = '0';
          eqfontSize = 38.0;
          resultFontSize = 48.0;
        }
      } else if (buttonText == '=') {
        eqfontSize = 38.0;
        resultFontSize = 48.0;

        expression = eq;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        eqfontSize = 48.0;
        resultFontSize = 38.0;
        if (eq == '0') {
          eq = buttonText;
        } else {
          eq = eq + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(
                  color: Colors.black, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              //stops: [0.2,0.3,1],
              colors: [
                Colors.purple.withOpacity(0.5),
                Colors.lightBlue.withOpacity(0.6),
                Colors.cyan.withOpacity(0.5)
              ],
            )),
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  eq,
                  style: TextStyle(fontSize: eqfontSize),
                ),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: resultFontSize),
                  )),
              Expanded(
                child: Divider(),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .75,
                      child: Table(
                        children: [
                          TableRow(children: [
                            buildButton("C", 1, Colors.redAccent),
                            buildButton("⌫", 1, Colors.blue),
                            buildButton("÷", 1, Colors.blue),
                          ]),
                          TableRow(children: [
                            buildButton("7", 1, Colors.black38),
                            buildButton("8", 1, Colors.black38),
                            buildButton("9", 1, Colors.black38),
                          ]),
                          TableRow(children: [
                            buildButton("4", 1, Colors.black38),
                            buildButton("5", 1, Colors.black38),
                            buildButton("6", 1, Colors.black38),
                          ]),
                          TableRow(children: [
                            buildButton("1", 1, Colors.black38),
                            buildButton("2", 1, Colors.black38),
                            buildButton("3", 1, Colors.black38),
                          ]),
                          TableRow(children: [
                            buildButton(".", 1, Colors.black38),
                            buildButton("0", 1, Colors.black38),
                            buildButton("00", 1, Colors.black38),
                          ])
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Table(
                        children: [
                          TableRow(children: [
                            buildButton("x", 1, Colors.lightBlue),
                          ]),
                          TableRow(children: [
                            buildButton("+", 1, Colors.lightBlue),
                          ]),
                          TableRow(children: [
                            buildButton("-", 1, Colors.lightBlue),
                          ]),
                          TableRow(children: [
                            buildButton("=", 2, Colors.redAccent),
                          ])
                        ],
                      ),
                    )
                  ])
            ])));
  }
}

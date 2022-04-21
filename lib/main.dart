import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.black),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor, Color textColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      width: MediaQuery.of(context).size.width * 0.5,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: textColor),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doofenshmirtz Scientific Narcilator', textAlign: TextAlign.right,)),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("AC", 1, Colors.black54, Colors.orange),
                      buildButton("⌫", 1, Colors.black54, Colors.orange),
                      buildButton("%", 1, Colors.black54, Colors.orange),
                      buildButton("÷", 1, Colors.black54, Colors.orange),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.black54, Colors.white),
                      buildButton("8", 1, Colors.black54, Colors.white),
                      buildButton("9", 1, Colors.black54, Colors.white),
                      buildButton("×", 1, Colors.black54, Colors.orange),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.black54, Colors.white),
                      buildButton("5", 1, Colors.black54, Colors.white),
                      buildButton("6", 1, Colors.black54, Colors.white),
                      buildButton("-", 1, Colors.black54, Colors.orange),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.black54, Colors.white),
                      buildButton("2", 1, Colors.black54, Colors.white),
                      buildButton("3", 1, Colors.black54, Colors.white),
                      buildButton("+", 1, Colors.black54, Colors.orange),
                    ]),
                    TableRow(children: [
                      buildButton("R", 1, Colors.black54, Colors.orange),
                      buildButton("0", 1, Colors.black54, Colors.white),
                      buildButton(".", 1, Colors.black54, Colors.white),
                      buildButton("=", 1, Colors.deepPurple, Colors.white),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

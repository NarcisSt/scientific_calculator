import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.black),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

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
      if (buttonText == "C") {
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
      } else if (buttonText == "↑") {
        equation = result;
        result = "0";
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('√', 'sqrt');
        expression = expression.replaceAll('e', '2.71828182846');
        expression = expression.replaceAll('π', '3.14159265359');
        expression = expression.replaceAll('lg', 'log');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';

          double dblRes = double.parse(result);
          var x = dblRes - dblRes.truncate();

          if (x == 0.0) {
            result = result.replaceAll('.0', '');
          }

          if (result.length > 20) {
            resultFontSize = 25.0;
            equationFontSize = 20.0;
          } else if (result.length > 10) {
            resultFontSize = 38.0;
            equationFontSize = 28.0;
          } else {
            resultFontSize = 48.0;
            equationFontSize = 38.0;
          }
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation.length > 16) {
          equationFontSize = 25.0;
          resultFontSize = 20.0;
        } else if (equation.length > 10) {
          equationFontSize = 38.0;
          resultFontSize = 28.0;
        } else {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
        }
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      Color textColor, double fontSz) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: fontSz,
                fontWeight: FontWeight.normal,
                color: textColor),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Doofenshmirtz Scientific Narcilator',
        textAlign: TextAlign.right,
      )),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("π", 1, Colors.black54, Colors.grey, 20.0),
                      buildButton("e", 1, Colors.black54, Colors.grey, 20.0),
                      buildButton("ln", 1, Colors.black54, Colors.grey, 20.0),
                      buildButton("(", 1, Colors.black54, Colors.grey, 30.0),
                      buildButton(")", 1, Colors.black54, Colors.grey, 30.0),
                    ]),
                    TableRow(children: [
                      buildButton("sin", 1, Colors.black54, Colors.grey, 20.0),
                      buildButton("C", 1, Colors.black54, Colors.orange, 30.0),
                      buildButton("⌫", 1, Colors.black54, Colors.orange, 30.0),
                      buildButton("%", 1, Colors.black54, Colors.orange, 30.0),
                      buildButton("÷", 1, Colors.black54, Colors.orange, 30.0),
                    ]),
                    TableRow(children: [
                      buildButton("cos", 1, Colors.black54, Colors.grey, 20.0),
                      buildButton("7", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("8", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("9", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("×", 1, Colors.black54, Colors.orange, 30.0),
                    ]),
                    TableRow(children: [
                      buildButton("tan", 1, Colors.black54, Colors.grey, 20.0),
                      buildButton("4", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("5", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("6", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("-", 1, Colors.black54, Colors.orange, 30.0),
                    ]),
                    TableRow(children: [
                      buildButton("√", 1, Colors.black54, Colors.grey, 20.0),
                      buildButton("1", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("2", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("3", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("+", 1, Colors.black54, Colors.orange, 30.0),
                    ]),
                    TableRow(children: [
                      buildButton("↑", 1, Colors.black54, Colors.grey, 30.0),
                      buildButton("0", 1, Colors.black54, Colors.white, 30.0),
                      buildButton("00", 1, Colors.black54, Colors.white, 30.0),
                      buildButton(".", 1, Colors.black54, Colors.white, 30.0),
                      buildButton(
                          "=", 1, Colors.deepPurple, Colors.white, 30.0),
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

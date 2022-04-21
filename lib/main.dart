import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scientific Calculator',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scientific Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              '0',
              style: TextStyle(fontSize: 38.0),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              '0',
              style: TextStyle(fontSize: 48.0),
            ),
          ),
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        color: Colors.red,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            padding: EdgeInsets.all(16.0),
                            onPressed: null,
                            child: Text(
                              "C",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            )),
                      )
                    ])
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

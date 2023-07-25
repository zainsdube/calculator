import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      equation,
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      result,
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Divider()),
            Column(
              children: [
                Row(
                  children: [
                    createButton('7'),
                    createButton('8'),
                    createButton('9'),
                    createButton('/'),
                  ],
                ),
                Row(
                  children: [
                    createButton('4'),
                    createButton('5'),
                    createButton('6'),
                    createButton('*'),
                  ],
                ),
                Row(
                  children: [
                    createButton('1'),
                    createButton('2'),
                    createButton('3'),
                    createButton('+'),
                  ],
                ),
                Row(
                  children: [
                    createButton('0'),
                    createButton('.'),
                    createButton('00'),
                    createButton('-'),
                  ],
                ),
                Row(
                  children: [
                    createButton('CLEAR'),
                    createButton('DELETE'),
                    createButton('='),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String equation = '0';
  String result = '0';
  String expression = '';

  buttonPressed(String myButton) {
    setState(() {
      if (myButton == 'CLEAR') {
        equation = '0';
        result = '0';
      } else if (myButton == 'DELETE') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (myButton == '=') {
        expression = equation;
        //expression = expression.replaceAll(from, replace)
        try {
          Parser myParser = Parser();
          Expression myExpression = myParser.parse(expression);
          ContextModel cm = ContextModel();
          result = '${myExpression.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Syntax Error';
        }
      } else {
        if (equation == '0') {
          equation = myButton;
        } else {
          equation = equation + myButton;
        }
      }
    });
  }

  //widget for building calculator buttons
  Widget createButton(String myButton) {
    return Expanded(
        child: SizedBox(
      height: 50.0,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: OutlinedButton(
          onPressed: () {
            buttonPressed(myButton);
          },
          child: Text(
            myButton,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    ));
  }
}

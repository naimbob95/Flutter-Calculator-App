import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:new_calculator_app/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                        child:
                            Text(userQuestion, style: TextStyle(fontSize: 20))),
                    Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userAnswer,
                          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        // clear button
                        if (index == 0) {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = '';
                                  userAnswer = '';
                                });
                              },
                              color: Colors.green,
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                        }
                        // Delete button
                        else if (index == 1) {
                          return MyButton(

                              buttonTapped: () {
                                if(userQuestion != ''){
                                  setState(() { 
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                });
                                }
                                
                              },
                              color: Colors.red,
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                        }
                        // ANSWER BUTTON
                        else if (index == buttons.length - 2){
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                   userQuestion = userAnswer;
                                });
                              },
                              color: Colors.white,
                              textColor: Colors.deepPurple,
                              buttonText: buttons[index]);
                        }
                        // EQUAL BUTTON
                        else if (index == buttons.length - 1) {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  equalPressed();
                                });
                              },
                              color: Colors.deepPurple,
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                        } else {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion += buttons[index];
                                });
                              },
                              color: isOperator(buttons[index])
                                  ? Colors.deepPurple
                                  : Colors.deepPurple[50],
                              textColor: isOperator(buttons[index])
                                  ? Colors.white
                                  : Colors.deepPurple,
                              buttonText: buttons[index]);
                        }
                      }),
                ))
          ],
        ));
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'X' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    
    // To replace the "x" with "*" because math expression detect "*" as multiply/darab not "x"
    finalQuestion = finalQuestion.replaceAll("X", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);

    ContextModel cm = ContextModel();

    // Evaluate expression:
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}

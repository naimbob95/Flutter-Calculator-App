import 'package:flutter/material.dart';
import 'package:new_calculator_app/buttons.dart';

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

  final List<String> buttons=[
    'C','DEL','%','/',
    '9','8','7','x',
    '6','5','4','-',
    '0','.','ANS','=',
  ];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     backgroundColor: Colors.deepPurple[100],
     body:Column(
       children:<Widget> [
       Expanded(child: Container(),),
       Expanded(
         flex:2,
         child: Container(
           child: GridView.builder(
             itemCount: buttons.length,
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (BuildContext context, int index){
              if(index == 0){
                return MyButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  buttonText:buttons[index]
                );
              }else if(index == 1){
                return MyButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  buttonText:buttons[index]
                );
              }else{
                return MyButton(
                  color:isOperator(buttons[index]) ? Colors.deepPurple: Colors.deepPurple[50],
                  textColor: isOperator(buttons[index]) ? Colors.white:Colors.deepPurple,
                  buttonText:buttons[index]
                );
              }
              
              
           
            }),
         )
            
       )
     ],
     )
    );
  }
  
  bool isOperator(String x){
    if(x == '%'||x == '/'||x == 'x'|| x == '-'||x == '+'||x == '='){
      return true;

    }
    return false;
  }
}

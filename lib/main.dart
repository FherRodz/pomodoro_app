import 'dart:async';
import 'package:pomodoro_app/countDownTimer.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  var _floatText = "START TASK!";
  var _time = 0;
  var _totalTaskTime = 0;
  var _totalRestTime = 0;
  var _isInTask = false;

  void _startTimer(){
    setState(() {
      _floatText = "STOP TASK!";
      if(_time == 0)
        _time = 25;
      else if(_time == 25){
        _totalTaskTime += 25;
        _time = 5;
      }
      else if(_time == 5){
        _totalRestTime += 5;
        _time = 25;
      }
    });
    print("entered startTimer");
    print("current time set to: $_time minutes");
  }

  void _stopTimer(){
    setState(() {
     _floatText = "START TASK!";
     _time = 0; 
    print("entered stopTimer");
    print("total ammount of time on task: $_totalTaskTime minutes");
    print("total ammount of time on rest: $_totalRestTime minutes");
    _totalTaskTime = 0;
    _totalRestTime = 0;
    });
    
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('The Pomodoro Helper'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Current timer going for:  ' + (_time).toString() + ' minutes', 
              textAlign: TextAlign.center, 
              style: Theme.of(context).textTheme.display1,
            ),
            CountDownTimer(secondsRemaining: 60*_time,
              whenTimeExpires: () => _startTimer(),
              countDownTimerStyle: TextStyle(
              color: Colors.black45,
              fontSize: 100.0,
              height: 1.2
            ),
          ),
            Container(
              height: 100,
              width: 100,
              child: 
              RawMaterialButton(
                child: Text(_floatText, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                fillColor: Colors.amber,
                shape: CircleBorder(),
                onPressed: () => {
                  _isInTask = !_isInTask,
                  if(_isInTask){
                    _startTimer()
                  }
                  else{
                    _stopTimer()
                  }
                },
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  onPressed: () => print('pressed contact'),
                  child: Text('Contact Us'),
                ),

                RaisedButton(
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  onPressed: () => print('pressed prev task'),
                  child: Text('Previous Tasks'),
                ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
class Timer1 extends StatefulWidget {
  int maxMinutes = 0;
  int maxHours = 0;

  Timer1(int currentM, int currentH){
    maxMinutes = currentM;
    maxHours = currentH;
  }
  @override
  _Timer1State createState() => _Timer1State(maxMinutes, maxHours);
}

class _Timer1State extends State<Timer1> {

  int maxSeconds = 0;
  int maxMinutes = 0;
  int maxHours = 0;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int totalM = 0;
  _Timer1State(int m, int h){
    // the time should be h > 0 || m > 0
    maxHours = h;
    maxMinutes = m;
    seconds = 0;

    hours = maxHours;
    minutes = maxMinutes;

    totalM = maxHours > 0 ? maxHours * 60 + maxMinutes : maxMinutes;
  }

   Timer? timer;

  void startTimer({bool reset = true}){
    if(reset)
    {
      resetTimer();
    }
    timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(()
      {
        if(seconds == 0)
        {
          if(minutes > 0)
          {
            minutes--;
            seconds = 59;
          }
          else if(minutes == 0)
            { // minutes == 0
              if(hours > 0)
              {
                hours--;
                minutes = 59;
                seconds = 59;
              }
              else if(hours == 0)
              {
                stopTimer(reset: true);
              }
          }
        }
        else if ( seconds > 0)
          {
            seconds--;
          }
      });
    });
  }
  void resetTimer() => setState(() {
    seconds = maxSeconds;
    minutes = maxMinutes;
    hours = maxHours;
  });
  void stopTimer({bool reset = true})
  {
    setState(() {
      timer!.cancel();
      if(reset)
      {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: maxMinutes == 0 ? "Yay! You have been fasting for ${(maxHours - hours - 1).toString().padLeft(2,'0')}  : ${(60 - minutes).toString().padLeft(2,'0')} m":
          "Yay! You have been fasting for ${(maxHours - hours).toString().padLeft(2,'0')} h: ${(60 - minutes+maxMinutes).toString().padLeft(2,'0')} m",
          backgroundColor: Color(0xFFFFBA52),
          confirmBtnColor: Color(0xFFFEE5B4),
          confirmBtnTextStyle: TextStyle(color: Colors.black) ,
        );
        resetTimer();
      }
    });
  }

  @override
  void dispose(){
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration : new BoxDecoration(
            gradient: new LinearGradient(colors: [const Color(0xff915fb5), const Color(0xFFCA436B)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimer(),
                const SizedBox(height: 80),
                buildButton(),
              ],
            ),
          ),
        )

    );
  }

  Widget buildButton()
  {
    var isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    if (isRunning || !isCompleted) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),),
            child: Text(isRunning ? "Pause" : "Resume", style: TextStyle(fontSize: 20, color: Colors.white),),
            onPressed: () {
              if (isRunning) {
                stopTimer(reset: false);
                isRunning = false;
              }
              else {
                startTimer(reset: false);
                isRunning = true;
              }},

          ),
          SizedBox(width: 12,),
          //ButtonWidget(text: 'Stop', onClicked: (){stopTimer();},),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),),
              child: Text("Stop", style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: (){stopTimer();}
          ),

        ],
      );
    } else {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),),
          child: Text("Start Timer!", style: TextStyle(fontSize: 20, color: Colors.black),),
          onPressed: (){startTimer();}
      );

    }
  }

  Widget buildTimer() => SizedBox(
    width: 350,
    height: 350,
    child: Stack(
      fit: StackFit.expand,
      children:[
        CircularProgressIndicator(
          value: maxHours > 1 ? ((hours*60)+minutes)/(totalM): minutes/(totalM),
          strokeWidth: 12,
          valueColor: AlwaysStoppedAnimation(Colors.white),
          backgroundColor: Colors.greenAccent,
        ),
        Center(child: buildTime())],
    )
    ,
  );

  Widget buildTime(){
    return Text('${(hours).toString().padLeft(2,'0')}:${(minutes).toString().padLeft(2,'0')}:${(seconds).toString().padLeft(2,'0')}', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),);
  }
}

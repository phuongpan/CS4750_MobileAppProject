import 'package:cool_alert/cool_alert.dart';
import 'package:fasting_diary/Time/fasting_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';
class SetTimer extends StatefulWidget {
  const SetTimer({Key? key}) : super(key: key);

  @override
  _SetTimerState createState() => _SetTimerState();
}

class _SetTimerState extends State<SetTimer> {

  int currentH = 0;
  int currentM = 0;

  Duration duration = Duration(minutes: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 8,
                child: Text('')),
            Expanded(
                flex: 5,
                child: Text('Pick your fasting time !', style: GoogleFonts.leckerliOne(fontSize:30, color: Color(0xFF787373)),
                )
            ),
            Expanded(
              flex: 25,
              child: Image(image: AssetImage('pictures/timer.png')),
            ),
            Expanded(
              flex: 40,
              child: Container(
                  width: 650,
                  height: 90,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFFFBA52),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)
                        )
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,),
                        Container(
                          margin: EdgeInsets.only(left: 80),
                          child: Row(
                            children: [
                              Text("Hours", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                              SizedBox(width: 65,),
                              Text("Minutes", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 68),
                          child: Row(
                            children: [
                              NumberPicker(
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(16),
                                    border:Border.all(color:Colors.black, width: 3) ),
                                value: currentH,
                                minValue: 0,
                                maxValue: 24,
                                itemHeight: 60,
                                textStyle: TextStyle(fontSize: 20),
                                selectedTextStyle: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold,),
                                onChanged: (value) => setState(() => currentH = value),
                              ),
                              SizedBox(width: 70,),
                              NumberPicker(
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(16),
                                    border:Border.all(color:Colors.black, width: 3) ),
                                value: currentM,
                                minValue: 0,
                                maxValue: 59,
                                itemHeight: 60,
                                textStyle: TextStyle(fontSize: 20),
                                selectedTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 50,),
                                onChanged: (value) => setState(() => currentM = value),
                              ),
                            ],
                          ),
                        ),

                        //buildTimerPicker(),
                        SizedBox(height: 25,),
                        ElevatedButton(
                            onPressed: (){
                              if(currentM != 0 || currentH != 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      Timer1(currentM, currentH)),);
                              }
                              else
                                {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: "Timer cannot start at 00:00",
                                    backgroundColor: Color(0xFFFFBA52),
                                    confirmBtnColor: Color(0xFFFEE5B4),
                                    confirmBtnTextStyle: TextStyle(color: Colors.black) ,
                                  );
                                }

                        },style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),),
                          child: Text("Done", style: TextStyle(fontSize: 20, color: Colors.black),),
                        ),
                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      ),);
  }
  Widget buildTimerPicker() => SizedBox(
      height: 220,
      child: CupertinoTimerPicker(
          initialTimerDuration: duration,
          mode: CupertinoTimerPickerMode.hms,
          minuteInterval: 10,
          onTimerDurationChanged: (duration)
          {
            setState(() => this.duration = duration);
          }
      )
  );
}
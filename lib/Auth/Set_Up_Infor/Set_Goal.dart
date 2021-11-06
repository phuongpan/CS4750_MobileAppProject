import 'package:cool_alert/cool_alert.dart';
import 'package:eatimer/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class SetGoal extends StatefulWidget {
  SetGoal({key, required this.currentWeight}) : super(key: key);
  int currentWeight;
  @override
  _SetGoalState createState() => _SetGoalState(currentWeight);
}

class _SetGoalState extends State<SetGoal> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  int setGoal = 50;
  int currentWeight;
  _SetGoalState(this.currentWeight);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("pictures/background.PNG"), fit: BoxFit.cover,),
              ),
            ),
            new Center(
              child: Column(
                children: [
                  SizedBox(height: 170,),
                  Text("Your Goal", style: GoogleFonts.leckerliOne(fontSize:35, color: Colors.black54),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 135),
                          child:Row(
                            children: [
                              NumberPicker(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border:Border.all(color:Colors.black54, width: 3) ),
                                value: setGoal,
                                minValue: 0,
                                maxValue: 200,
                                itemHeight: 120,
                                itemWidth: 120,
                                textStyle: TextStyle(fontSize: 30, color:Colors.black54),
                                selectedTextStyle: TextStyle(color: Colors.black, fontSize: 80, fontWeight: FontWeight.bold,),
                                onChanged: (value) => setState(() => setGoal = value),
                              ),
                              SizedBox(width: 10,),
                              Text("kg", style: TextStyle(color: Colors.black54,fontSize: 50 ),)
                            ],
                          ),
                        ),

                        SizedBox(height: 25,),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                            if(currentWeight == setGoal)
                              {
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: 'Sign In failed',
                                    backgroundColor: Color(0xFFFFBA52),
                                    confirmBtnColor: Color(0xFFFEE5B4),
                                    confirmBtnTextStyle: TextStyle(color: Colors.black));
                              }
                            else{
                              FirebaseDatabase.instance.reference().child('Infor').set({
                                "currentWeight": currentWeight,
                                "goalWeight": setGoal,
                              }).then((value) {

                                print("Successfully Set Goal");
                              }).catchError((error){
                                print("Failed to set goal"+ error.toString());
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFFEE5B4),
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),),
                          child: Text("Done", style: TextStyle(fontSize: 20, color: Colors.black),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}

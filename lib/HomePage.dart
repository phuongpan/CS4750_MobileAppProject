import 'package:eatimer/Notes/Recipe_Details.dart';
import 'package:eatimer/Time/setTimer.dart';
import 'package:eatimer/Water/water_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  int _selectedIndex = 0;
  int currentWeight=0;
  int goalWeight=0;
  int totalWeight = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    SetTimer(),
    RecipeDetails(),
    WaterPage(),
  ];
  _HomePageState() {
    refreshList();
    // FirebaseDatabase.instance.reference().child('Infor').once().then((datasnapshot) {
    //   print("Successfully loaded the data");
    //   print(datasnapshot);
    //   print(datasnapshot.value['currentWeight']);
    //   print(datasnapshot.value['goalWeight']);
    //   currentWeight = int.parse(datasnapshot.value['currentWeight'].toString());
    //   goalWeight= int.parse(datasnapshot.value['goalWeight'].toString());
    //   totalWeight = currentWeight - goalWeight;
    //   print(totalWeight);
    // }).catchError((error){
    //   print("Failed to load the data");
    // });
  }
  void refreshList(){
    FirebaseDatabase.instance.reference().child('Infor').once().then((datasnapshot) {
      print("Successfully loaded the data");
      print(datasnapshot.value);
      currentWeight = int.parse(datasnapshot.value['currentWeight'].toString());
      goalWeight= int.parse(datasnapshot.value['goalWeight'].toString());
      totalWeight = currentWeight - goalWeight;
      setState(() {
      });
    }).catchError((error){
      print("Failed to load the data");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
          Expanded(
            flex: 40,
              child: Image(image: totalWeight > 0 ? AssetImage('pictures/lose_weight.png'):AssetImage('pictures/gain_weight.png'))
          ),

            Expanded(
              flex: 30,
              child: Container(
                margin: EdgeInsets.only(top:20),
                child: Column(
                children: [
                  Text("Your Current Weight", style: TextStyle(fontSize: 25,color: Colors.black54),),
                  Text("$currentWeight", style: TextStyle(fontSize: 100, color: Colors.black),),
                  if(totalWeight > 0)
                    Text("You need to lose $totalWeight kg to reach your goal",style: TextStyle(fontSize: 15,color: Colors.black54),)
                  else
                    Text("You need to gain ${totalWeight*-1} kg to reach your goal",
                      style: TextStyle(fontSize: 15, color: Colors.black54),),
                  Text("Your Goal: ${goalWeight.toString()}kg", style: TextStyle(fontSize: 15,color: Colors.black54),),
                ],
              ),),
            ),
            Expanded(
              flex: 25,
              child: Container(
                width: 650,
                height: 100,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      width: 200,
                      height: 50,
                      child:Material(
                        elevation: 5.0,
                        color: Color(0xFFFFBA52),
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                          child: Text('Weight Yourself', style: TextStyle(color: Colors.black, fontSize: 20),),
                          onPressed: () => showMaterialNumberPicker(
                          context: context,
                          title: 'Your Current Weight',
                          headerColor: Colors.orange,
                          headerTextColor: Colors.black,
                          buttonTextColor: Colors.orange,
                          maxNumber: 200,
                          minNumber: 0,
                          confirmText: 'Done',
                          cancelText: 'Cancel',
                          selectedNumber: currentWeight,
                          onChanged: (value){
                            setState(() {
                            currentWeight = value;
                            FirebaseDatabase.instance.reference().child('Infor').set({
                              "currentWeight": currentWeight,
                              "goalWeight": goalWeight,
                            }).then((value) {
                              print("Successfully update current weight");
                            }).catchError((error){
                              print("Failed to add. "+ error.toString());
                            });
                            totalWeight = currentWeight - goalWeight;
                            },);
                          }
                      ),
                      ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 120.0,
                      height: 50,
                      child: Material(
                        elevation: 5.0,
                        color: Color(0xFFFFBA52),
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                            onPressed: () => showMaterialNumberPicker(
                                context: context,
                                title: 'Your Goal',
                                headerColor: Colors.orange,
                                headerTextColor: Colors.black,
                                buttonTextColor: Colors.orange,
                                maxNumber: 200,
                                minNumber: 0,
                                confirmText: 'Done',
                                cancelText: 'Cancel',
                                selectedNumber: goalWeight,
                                onChanged: (value){
                                  setState(() {
                                    goalWeight = value;
                                    FirebaseDatabase.instance.reference().child('Infor').set({
                                      "currentWeight": currentWeight,
                                      "goalWeight": goalWeight,
                                    }).then((value) {
                                      print("Successfully update goal weight");
                                    }).catchError((error){
                                      print("Failed to add. "+ error.toString());
                                    });
                                    totalWeight = currentWeight - goalWeight;
                                  },);
                                }
                            ),
                            child: Text('Set Goal', style: TextStyle(color: Colors.black, fontSize: 20),)),

                      ),
                    ),
                  ],
                )
                ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_rounded, color: Color(0xFFFFBA52),),
            label: 'Timer',
            backgroundColor: Color(0xFFFEE5B4),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dining_outlined,color: Color(0xFFFFBA52)),
            label: 'Recipe',
            backgroundColor: Color(0xFFFEE5B4),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink_rounded,color: Color(0xFFFFBA52)),
            label: 'Water',
            backgroundColor: Color(0xFFFEE5B4),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _widgetOptions[_selectedIndex]),);

    });
  }
  Widget buildPicker() => NumberPicker(
      value: currentWeight,
      minValue: 0,
      maxValue: 150,
      onChanged: (value)
      { setState(() =>  currentWeight = value);}
  );
}

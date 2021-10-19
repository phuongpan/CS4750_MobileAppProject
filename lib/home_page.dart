

import 'package:fasting_diary/recipe.dart';
import 'package:fasting_diary/Time/setTimer.dart';
//import 'package:fasting_diary/recipe_page.dart';
import 'package:fasting_diary/Time/time_page.dart';
import 'package:fasting_diary/water_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/dialogs/scroll_picker_dialog.dart';
import 'dart:async';
class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.name}) : super(key: key);
  String name;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    //TimePage(),
    //Timer1(),
    SetTimer(),
    Recipe(),
    //RecipePage(),
    WaterPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _widgetOptions[_selectedIndex]),);

    });
  }
  int _currentWeight = 50;
  int _goalWeight = 50;

  Widget buildPicker() => NumberPicker(
      value: _currentWeight,
      minValue: 0,
      maxValue: 150,
      onChanged: (value)
      { setState(() =>  _currentWeight = value);}
  );
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
                child: Text('Welcome ${this.widget.name}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                )
            ),
            Expanded(
              flex: 25,
              child: CircleAvatar(
                backgroundImage: AssetImage('pictures/avatar.jpg'),
                radius: 100,
              ),
            ),
            Expanded(
              flex: 50,
                child:Container(
                  width: 650,
                  height: 100,
                  child: Container(
                          decoration: BoxDecoration(
                          color: Color(0xFFFFBA52),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)
                          )),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 25,right: 205, bottom: 20),
                                child: Text('Your Weight',
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                            ),
                            Container(
                              width: 150.0,
                              height: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:  MaterialStateProperty.all<Color>(Color(0xFFFEE5B4)),
                                ) ,
                                child: Text('${_currentWeight}', style: TextStyle(color: Colors.black, fontSize: 60),),
                                onPressed: () => showMaterialNumberPicker(
                                  context: context,
                                  title: 'Your Current Weight',
                                  headerColor: Colors.orange,
                                  headerTextColor: Colors.black,
                                  buttonTextColor: Colors.orange,
                                  maxNumber: 100,
                                  minNumber: 15,
                                  step: 5,
                                  confirmText: 'Done',
                                  cancelText: 'Cancle',
                                  selectedNumber: _currentWeight,
                                  onChanged: (value) => setState(() => _currentWeight = value),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10,right: 205, bottom: 20),
                                child: Text('Your Goal',
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                            ),
                            Container(
                              width: 150.0,
                              height: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:  MaterialStateProperty.all<Color>(Color(0xFFFEE5B4)),
                                ) ,
                                child: Text('${_goalWeight}', style: TextStyle(color: Colors.black, fontSize: 60),),
                                onPressed: () => showMaterialNumberPicker(
                                  context: context,
                                  title: 'Your Goal',
                                  headerColor: Colors.orange,
                                  headerTextColor: Colors.black,
                                  buttonTextColor: Colors.orange,
                                  maxNumber: 100,
                                  minNumber: 15,
                                  step: 5,
                                  confirmText: 'Done',
                                  cancelText: 'Cancle',
                                  selectedNumber: _goalWeight,
                                  onChanged: (value) => setState(() => _goalWeight = value),
                                ),
                              ),
                            ),
                          ],
                        ),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.list, color: Color(0xFFFFBA52)),
          //   label: 'Option',
          //   backgroundColor: Color(0xFFFEE5B4),
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

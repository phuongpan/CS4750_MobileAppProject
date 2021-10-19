import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  _WaterPageState createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  int add = 0;
  int goal = 10;

  void addW()
  {
    setState(() {
      add++;
    });
  }

  void minusW()
  {
    int check = add-1;
    if(check == -1)
      {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: "Let's drink more water !",
          backgroundColor: Color(0xFFFFBA52),
          confirmBtnColor: Color(0xFFFEE5B4),
          confirmBtnTextStyle: TextStyle(color: Colors.black) ,
        );
      }
    else
      {
        setState(() {
          add--;
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Let's Drink", style: TextStyle(fontSize: 20),),
        centerTitle: true,
        actions: [
          new IconButton(
            onPressed: () => showMaterialNumberPicker(
              context: context,
              title: 'Choose your goal',
              headerColor: Colors.orange,
              headerTextColor: Colors.black,
              buttonTextColor: Colors.orange,
              minNumber: 0,
              maxNumber: 24,
              confirmText: 'Done',
              cancelText: 'Cancle',
              selectedNumber: goal,
              onChanged: (value) =>setState(() {
                goal = value;
                print(goal.toString());
              }),
            ),
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        children: [

        Padding(
          padding: EdgeInsets.all(0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(top:25),
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Processing', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                const SizedBox(height: 20),
                                buildTimer(),
                                const SizedBox(height: 90),
                                buildButton(),
                            ],
                          ),
                        ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  Widget buildButton()
  {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),),
            child: Text("Add", style: TextStyle(fontSize: 20, color: Colors.white),),
            onPressed: () {
              if(add < goal)
                {
                  addW();
                }
              else
                {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: "Yay! You completed you goal",
                    backgroundColor: Color(0xFFFFBA52),
                    confirmBtnColor: Color(0xFFFEE5B4),
                    confirmBtnTextStyle: TextStyle(color: Colors.black) ,
                  );
                }
            }
          ),
          SizedBox(width: 12,),
          //ButtonWidget(text: 'Stop', onClicked: (){stopTimer();},),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),),
              child: Text("Minus", style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: (){
                minusW();
              }
          ),

        ],
      );
  }

  Widget buildTimer() => SizedBox(
    width: 350,
    height: 350,
    child: Stack(
      fit: StackFit.expand,
      children:[
        CircularProgressIndicator(
          value: add/goal,
          strokeWidth: 12,
          valueColor: AlwaysStoppedAnimation(Colors.orange),
          backgroundColor: Color(0xFFFEE5B4),
        ),
        Center(child: buildTime())],
    )
    ,
  );

  Widget buildTime(){
    return Column(
      children: [
        SizedBox(height: 50,),
        Container(
          width: 200,
            height: 200,
            child: Image(image: AssetImage('pictures/orange-water.png')),
        ),
        SizedBox(height: 20,),
        Text('$add/$goal', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.orange),),
      ],
    );
  }
}

import 'package:fasting_diary/screens/UpdateNotes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fasting_diary/screens/add_screen.dart';
import 'package:fasting_diary/home_page.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var RecipeList = [];
  var KeyList = [];

  _HomeScreenState(){
    refreshList();
    FirebaseDatabase.instance.reference().child('List-recipe').onChildChanged.listen((event) {
      print("Data changed");
      refreshList();
    });
    FirebaseDatabase.instance.reference().child('List-recipe').onChildRemoved.listen((event) {
      refreshList();
    });
  }

  void refreshList(){
    FirebaseDatabase.instance.reference().child('List-recipe').once().then((datasnapshot) {
      print("Successfully loaded the data");
      print(datasnapshot);
      var tempList = [];
      var tempKey = [];
      datasnapshot.value.forEach((k,v){
        tempKey.add((k));
        tempList.add((v));
      });

      print("Final list:");
      print(tempKey);
      print(tempList);
      KeyList = tempKey;
      RecipeList = tempList;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),);
          refreshList();
        },
        backgroundColor: Color(0xFFFFBA52),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Save Your Recipe', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(name: 'Natalia')),);
            },
          child: Icon(
            Icons.chevron_left, color: Colors.black, // add custom icons also
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: RecipeList.length,
        itemBuilder: (BuildContext context, int index)
        {
          return ListTile(
          onTap: () async {
            print(KeyList[index]);
            String name = KeyList[index].toString();
            print(name);
            await Navigator.push(context,MaterialPageRoute(builder: (context) => UpdateNotes(name: name)),);
            refreshList();
          },
            title: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFFFFBA52),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  Text("${RecipeList[index]['title']}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${RecipeList[index]['description']}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      )

      );
  }
}


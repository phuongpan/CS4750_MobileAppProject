import 'package:fasting_diary/screens/HomeScreen.dart';
import 'package:fasting_diary/screens/add_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class UpdateNotes extends StatefulWidget {
  UpdateNotes({Key? key, required this.name}) : super(key: key);
  String name;
  @override
  _UpdateNotesState createState() => _UpdateNotesState(name);
}

class _UpdateNotesState extends State<UpdateNotes> {
  String titleController = '';
  String descriptionController = '' ;
  TextEditingController despController = TextEditingController();
  TextEditingController titleUController = TextEditingController();
  String name;
  DatabaseReference ref = FirebaseDatabase.instance.reference();

  _UpdateNotesState(this.name){
    FirebaseDatabase.instance.reference().child('List-recipe/$name').once().then((datasnapshot) {
      print("Successfully loaded the data");
      print(datasnapshot);
      print(datasnapshot.value['title']);
      print(datasnapshot.value['description']);
      titleController = datasnapshot.value['title'].toString();
      descriptionController  = datasnapshot.value['description'].toString();
      despController.text = descriptionController;
      titleUController.text = titleController;
    }).catchError((error){
      print("Failed to load the data");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Save your Recipe', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFFEE5B4),
        actions: [
          new IconButton(
            onPressed: () => showDialog(context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("Delete the note"),
                  content: Text("Are you sure?"),
                  actions: [
                    TextButton(onPressed: ()=> Navigator.pop(context, 'Cancel'), child: Text('Cancel')),
                    TextButton(onPressed:  () async {

                      FirebaseDatabase.instance.reference().child('List-recipe').child(name).remove();
                      setState(() {});
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
                      }, child: const Text('Delete'),)
                  ],
                )),
            icon: Icon(Icons.settings),
          )
        ],
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.chevron_left, color: Colors.black, // add custom icons also
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: titleController.toString(),
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              controller: titleUController,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              onChanged: (value){
                titleController = value;
              },
              //controller: titleController,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: descriptionController,
                  hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                ),
                style: TextStyle(fontSize: 17, color: Colors.black),
                maxLines: null,
                controller: despController,
                onChanged: (value){
                  descriptionController = value;
                },
                //controller: descriptionController,
              ),
            ),
            FlatButton(
                onPressed: (){

                  Navigator.pop(context);
                  FirebaseDatabase.instance.reference().child('List-recipe/$name').set({
                    "title": titleController,
                    "description": descriptionController
                  }).then((value) {
                    print("Successfully added to the Recipe's List");
                  }).catchError((error){
                    print("Failed to add. "+ error.toString());
                  });
                },
                color: Color(0xFFFFBA52),
                child: Text('Add Note',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                )
            )
          ],
        ),
      ),
    );
  }
}


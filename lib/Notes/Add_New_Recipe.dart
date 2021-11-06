import 'package:eatimer/Notes/Recipe_Details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Save your Recipe', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFFEE5B4),
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
                hintText: 'Enter title',
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              controller: titleController,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Description',
                  hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                ),
                style: TextStyle(fontSize: 17, color: Colors.black),
                maxLines: null,
                controller: descriptionController,
              ),
            ),
            FlatButton(
                onPressed: (){
                  var timestamp = new DateTime.now().millisecondsSinceEpoch;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetails()),);
                  FirebaseDatabase.instance.reference().child('List-recipe/recipe'+ timestamp.toString()).set({
                    "title": titleController.text,
                    "description": descriptionController.text
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fasting_diary/Notes/NoteOperation.dart';
import 'package:fasting_diary/Notes/Notes.dart';
import 'package:fasting_diary/screens/add_screen.dart';
import 'package:fasting_diary/home_page.dart';
class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({key}) : super(key: key);

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),);
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
    //
    );
  }
}

class NotesCard extends StatelessWidget {
  final Note note;
  NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(note.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(note.description,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

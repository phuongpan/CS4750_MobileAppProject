import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fasting_diary/Notes/NoteOperation.dart';
import 'package:fasting_diary/screens/HomeScreen.dart';
class Recipe extends StatefulWidget {
  const Recipe({key}) : super(key: key);

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NoteOperation>(
      create: (context)=> NoteOperation(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

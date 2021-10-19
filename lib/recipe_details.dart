import 'package:fasting_diary/recipe_page.dart';
import 'package:fasting_diary/Time/time_page.dart';
import 'package:flutter/material.dart';

import 'water_page.dart';
class RecipeDetails extends StatefulWidget {
  RecipeDetails(this.title);

  String title;
  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget
{
  @override
  final Size preferredSize;
  final String title;
  CustomAppBar(
      this.title,
      {Key? key,}) : preferredSize = Size.fromHeight(50.0), super(key: key);
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: Color(0xFFFEE5B4),
      title: Center(child: Text("${this.title}",
        style: TextStyle(color: Colors.black),)),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.chevron_left, color: Colors.black, // add custom icons also
        ),
      ),
    );
  }

}


class _RecipeDetailsState extends State<RecipeDetails> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    TimePage(),
    RecipePage(),
    WaterPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => _widgetOptions[_selectedIndex]),);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(this.widget.title),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFEE5B4),
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.check, color: Color(0xFFFFBA52),),
            label: 'Save',
            backgroundColor: Color(0xFFFFBA52),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined,color: Color(0xFFFFBA52)),
            label: 'Camera',
            backgroundColor: Color(0xFFFEE5B4),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_rounded,color: Color(0xFFFFBA52)),
            label: 'Write',
            backgroundColor: Color(0xFFFEE5B4),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
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
     backgroundColor: Colors.white,
     title: Center(child: Text("Save Your Recipe",
       style: TextStyle(color: Colors.black),)),
     leading: GestureDetector(
       onTap: () => Navigator.pop(context),
       child: Icon(
         Icons.chevron_left, color: Colors.black, // add custom icons also
       ),
     ),
     // actions: <Widget>[
     //   Padding(
     //       padding: EdgeInsets.only(right: 20.0),
     //       child: GestureDetector(
     //         onTap: ()
     //         {
     //           setState(){}
     //         },
     //         child: Icon(
     //             Icons.add,
     //           color: Colors.black,
     //         ),
     //       )
     //   ),
     // ],
   );
  }

}

class _RecipePageState extends State<RecipePage> {
  final List<String> recipe = ['recipe 1', 'recipe 2', 'recipe 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar('Recipe'),
      body: Column(
        children: [
          Spacer(),
          Image(image: AssetImage('pictures/Recipe.PNG')),
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
                        )
                    ),
                    child: ListView.builder(
                        itemCount: recipe.length,
                        itemBuilder: (BuildContext context, int index)
                    {
                      return ListTile(
                        onTap: ()
                          {
                             // Navigator.push(
                             //   context,
                             //   MaterialPageRoute(builder: (context) => RecipeDetails(recipe[index])),);
                          },
                        title: Container(
                          margin: EdgeInsets.only(top: 10),
                          child:
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xFFFEE5B4),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                              child: Center(child: Text('${recipe[index]}'))),
                        ),

                      );
                    })
                ),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // String new_recipe= 'New Recipe';
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => RecipeDetails(new_recipe)),);
        },
        backgroundColor: Color(0xFFFEE5B4),
        child: Icon(Icons.add, color: Colors.black,),
      ),
    );
  }
}

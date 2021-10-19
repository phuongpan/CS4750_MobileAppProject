import 'package:fasting_diary/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:fasting_diary/sign_in_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       // backgroundColor: Color(0xFFFEE5B4),
          canvasColor: Color(0xffFEE5B4),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.dark,
          accentColor: Color(0xffFFBA52)
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
    late AnimationController controller;
    late Animation animation;

    @override
    void initState(){
      super.initState();
      controller = AnimationController(
          duration: Duration(seconds: 10),
          vsync: this
      );
      // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
      animation = ColorTween(begin:Colors.red, end:Colors.blue).animate(controller);
      controller.forward();

      // animation.addStatusListener((status) {
      //   if(status == AnimationStatus.completed)
      //     {
      //       controller.reverse(from: 1.0);
      //     }else if(status == AnimationStatus.dismissed)
      //       {
      //         controller.forward();
      //       }
      // });

      controller.addListener(() {
        setState(() {
        });

      });
    }

    @override
    void dispose(){
      controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFEE5B4),

      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          children:[
            SizedBox(height: 50,),
           Padding(
                padding: const EdgeInsets.only(bottom: 180),
                child: Column(
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image(
                          image: AssetImage('pictures/SignIn.PNG'),
                          fit: BoxFit.cover,
                        height: 300,
                        ),
                    ),
                   SizedBox(height: 25,),
                   DefaultTextStyle(
                        style: GoogleFonts.leckerliOne(fontSize:60, color: Color(0xFF787373)),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('Eatimer'),
                          ],
                          isRepeatingAnimation: true,
                        ),
                      ),

                    //Text("Eatimer", style: GoogleFonts.leckerliOne(fontSize:60, color: Color(0xFF787373)),)
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5.0,
                color: Color(0xFFFFBA52),
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  minWidth: 300.0,
                    height: 42,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninPage() ),);

                    },
                    child: Text('Log In', style: TextStyle(fontSize: 20),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5.0,
                color: Color(0xFFFFBA52),
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                    minWidth: 300.0,
                    height: 42,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage() ),);

                    },
                    child: Text('Register', style: TextStyle(fontSize: 20),)),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ]
        ),
      )
    );
  }
}

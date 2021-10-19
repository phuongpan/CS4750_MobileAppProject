import 'package:fasting_diary/home_page.dart';
import 'package:fasting_diary/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:google_fonts/google_fonts.dart';
class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFFEE5B4) ,
      body:
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Expanded(
                      flex: 10,
                      child:
                      Text(''),
                  ),
                  Container(
                      height: 160,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20, left: 20),
                            child: Hero(
                              tag: 'logo',
                              child: Image(
                                image: AssetImage('pictures/SignIn.PNG'),
                                height: 160,
                              ),
                            ),
                          ),
                          Text("Eatimer", style: GoogleFonts.leckerliOne(fontSize:60, color: Color(0xFF787373)),)
                        ],
                      ),
                    ),
                  Expanded(
                    flex:20,
                    child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom:10, left:50, right:50),
                            child: TextField(
                              controller: emailController,
                              style: TextStyle(color: Colors.black),
                              obscureText: false, // to hide the text when typing
                              decoration: InputDecoration(
                                // border: OutlineInputBorder(),
                                labelText: 'Enter Username',
                                filled: true,
                                fillColor: Color(0xFFFFFCFC),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom:10, left:50, right:50),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              controller: passwordController ,
                              obscureText: true, // to hide the text when typing
                              decoration: InputDecoration(
                                // border: OutlineInputBorder(),
                                labelText: ' Enter Password',
                                filled: true,
                                fillColor: Color(0xFFFFFCFC),
                                ),
                              ),
                            ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {},
                            child: const Text('Forgot Password',
                                style: TextStyle(
                                    color: Color(0xFFFB9600),
                                    fontWeight: FontWeight.bold,
                                )
                            ),
                          ),

                        ]
                    ),
                  ),
                  Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          elevation: 5,
                          color: Color(0xffFFBA52),
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            minWidth: 300,
                              height: 42,
                              child: Text('Log In', style: TextStyle(fontSize: 20),),
                              onPressed: () {
                                  FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailController.text,
                                   password: passwordController.text).then((value){
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(name: 'Natalia')),);
                                   }).catchError((error) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: error.toString(),
                                  backgroundColor: Color(0xFFFFBA52),
                                  confirmBtnColor: Color(0xFFFEE5B4),
                                  confirmBtnTextStyle: TextStyle(
                                      color: Colors.black),
                                );
                              });
                            //Firebase- Authetication

                          },
                        ),
                      ),
                  ),
                  Expanded(
                    flex:10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                    Text('Do not have an account', style: TextStyle(color: Colors.black54,),),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),);
                        },
                        child: const Text('Sign up',
                            style: TextStyle(
                              color: Color(0xFFFB9600),
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),

                    ]
                  )
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

import 'package:fasting_diary/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cool_alert/cool_alert.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmedPassController = TextEditingController();
  var success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEE5B4),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children:[
              Expanded(
              flex: 15,
              child: Text('')),
              Expanded(
                  flex: 10,
                  child: Text('Welcome to Eatimer !',
                  style: GoogleFonts.leckerliOne(fontSize:34, color: Color(0xFF787373)),
                  )
              ),
              Hero(
                tag: 'logo',
                child: Container(
                  height: 160,
                  child: Image(
                    image: AssetImage('pictures/SignIn.PNG'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                  child: Text('Let\'s get you started.',
                  style: GoogleFonts.inriaSans(fontSize: 20, color: Color(0xFF787373) ),

                  )
              ),
              Expanded(
                flex: 50,
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom:20, left:50, right:50),
                    child: TextField(
                      controller: nameController,
                      obscureText: false, // to hide the text when typing
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Enter Your Name',
                        filled: true,
                        fillColor: Color(0xFFFFFCFC),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom:20, left:50, right:50),
                    child: TextField(
                      controller: emailController,
                      obscureText: false, // to hide the text when typing
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Enter Your Email',
                        filled: true,
                        fillColor: Color(0xFFFFFCFC),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom:20, left:50, right:50),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true, // to hide the text when typing
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Enter Your Password',
                        filled: true,
                        fillColor: Color(0xFFFFFCFC),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom:10, left:50, right:50),
                    child: TextField(
                      controller: confirmedPassController,
                      obscureText: true, // to hide the text when typing
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Confirm Your Password',
                        filled: true,
                        fillColor: Color(0xFFFFFCFC),
                      ),
                    ),
                  ),

                ],
              )
              ),

            Expanded(
              flex: 8,
              child: Container(
                  width: 250,
                  child:

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFBA52)),
                    ),

                    child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    onPressed: () {
                      //1. Get the information typed
                      print(nameController.text);
                      print(emailController.text);
                      print(passwordController.text);
                      print(confirmedPassController.text);
                      // 2. Send it to Firebase Auth
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text).then((value){
                              print('Successfully Signed Up');
                              //https://pub.dev/packages/cool_alert/example
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: 'Successfully Signed Up',
                                  backgroundColor: Color(0xFFFFBA52),
                                  confirmBtnColor: Color(0xFFFEE5B4),
                                  confirmBtnText: 'Yay!',
                                  confirmBtnTextStyle: TextStyle(color: Colors.black),
                              onConfirmBtnTap: ()=> Navigator.pop(context));
                          }).catchError((error) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: error.toString(),
                            backgroundColor: Color(0xFFFFBA52),
                            confirmBtnColor: Color(0xFFFEE5B4),
                            confirmBtnTextStyle: TextStyle(color: Colors.black) ,
                        );
                      });
                    }
                  ),
                ),
            ),
              Expanded(
                  flex:10,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('Already have an account'),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SigninPage()),);
                          },
                          child: const Text('Sign in',
                              style: TextStyle(
                                color: Color(0xFFFB9600),
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ),

                      ]
                  )
              ),
              Expanded(
                flex: 10,
                  child: Text(''))
            ]
          ),
        ),
      )
    );
  }
}

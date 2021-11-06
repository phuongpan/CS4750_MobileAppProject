
import 'package:eatimer/Auth/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cool_alert/cool_alert.dart';

import 'Set_Up_Infor/Get_Current_Weight.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPassController = TextEditingController();

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
                  height: 170,
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
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      obscureText: false, // to hide the text when typing
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        labelText: 'Enter Your Email',
                        labelStyle: TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: Color(0xFFFFFCFC),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom:20, left:50, right:50),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true, // to hide the text when typing
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        labelText: 'Enter Your Password',
                        labelStyle: TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: Color(0xFFFFFCFC),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom:10, left:50, right:50),
                    child: TextField(
                      controller: confirmedPassController,
                      obscureText: true, // to hide the text when typing
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                        labelText: 'Confirm Your Password',
                        labelStyle: TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: Color(0xFFFFFCFC),
                      ),
                      style: TextStyle(color: Colors.black),
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

                  Material(
                    elevation: 5,
                    color: Color(0xffFFBA52),
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                        minWidth: 300,
                        height: 42,
                    child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    onPressed: () async{

                      final User? user = (await _auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      )).user;

                      if(user != null)
                      {
                        print('Successfully Signed Up');
                        setState(() {
                        });
                        //https://pub.dev/packages/cool_alert/example
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: 'Successfully Signed Up',
                            backgroundColor: Color(0xFFFFBA52),
                            confirmBtnColor: Color(0xFFFEE5B4),
                            confirmBtnText: 'Yay!',
                            confirmBtnTextStyle: TextStyle(
                                color: Colors.black),
                            onConfirmBtnTap: () async => Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentWeight()),));
                      }
                      else{
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: 'Registration failed',
                          backgroundColor: Color(0xFFFFBA52),
                          confirmBtnColor: Color(0xFFFEE5B4),
                          confirmBtnTextStyle: TextStyle(color: Colors.black),
                        );
                      }
                    }
                  ),
                ),
              )
            ),
              Expanded(
                  flex:10,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('Already have an account', style: TextStyle(color: Colors.black38),),
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}


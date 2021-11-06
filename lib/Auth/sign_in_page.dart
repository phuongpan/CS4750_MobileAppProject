import 'package:eatimer/HomePage.dart';
import 'package:eatimer/Auth/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  User? user;

  @override
  void initState() {
    _auth.userChanges().listen(
          (event) => setState(() => user = event),
    );
    super.initState();
  }

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
                      flex: 5,
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
                  Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom:10, left:25, right:25),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            style: TextStyle(color: Colors.black),
                            obscureText: false, // to hide the text when typing
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                              labelText: 'Enter Username',
                              labelStyle: TextStyle(color: Colors.black38),
                              filled: true,
                              fillColor: Color(0xFFFFFCFC),
                            ),
                          ),
                        ),
                        Container(
                          width: 350,
                          margin: EdgeInsets.only(bottom:10, left:25, right:25),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _passwordController ,
                            obscureText: true, // to hide the text when typing
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                              labelText: ' Enter Password',
                              labelStyle: TextStyle(color: Colors.black38),
                              filled: true,
                              fillColor: Color(0xFFFFFCFC),
                              ),
                            ),
                          ),
                        // TextButton(
                        //   style: TextButton.styleFrom(
                        //     textStyle: const TextStyle(fontSize: 15),
                        //   ),
                        //   onPressed: () {},
                        //   child: const Text('Forgot Password',
                        //       style: TextStyle(
                        //           color: Color(0xFFFB9600),
                        //           fontWeight: FontWeight.bold,
                        //       )
                        //   ),
                        // ),

                      ]
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50,bottom:10, left:50, right:50),
                    child: Material(
                      elevation: 5,
                      color: Color(0xffFFBA52),
                      borderRadius: BorderRadius.circular(30.0),
                      child: MaterialButton(
                        minWidth: 300,
                          height: 42,
                          child: Text('Log In', style: TextStyle(fontSize: 20),),
                          onPressed: () async{

                            final User? user = (await _auth.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )).user;

                            if(user != null)
                            {
                              print('Successfully Signed In');
                              setState(() {
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                            }
                            else{
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text: 'Sign In failed',
                                backgroundColor: Color(0xFFFFBA52),
                                confirmBtnColor: Color(0xFFFEE5B4),
                                confirmBtnTextStyle: TextStyle(color: Colors.black),
                              );
                            }
                          }
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

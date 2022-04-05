
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glamourme/view/auth/login/login.dart';
import 'package:glamourme/view/auth/signup.dart/signup.dart';
import 'package:provider/provider.dart';

import '../../model/google_signin.dart';
import '../../utils/style.dart';
import '../widgets/google_signin_btn.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: const Text(
            'Password Reset Email has been sent !',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'No user found for that email.',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: verticlePadding * 2,
                          // ),
                          // CustomAppBar(),
                          SizedBox(
                            height: height * .12,
                          ),
                          Text(
                            'Reset Link will be sent to your email id!',
                            textAlign: TextAlign.center,
                            style: titleTextStyle(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: padding),
                            child: Container(
                              //padding: EdgeInsets.symmetric(horizontal: 25,vertical: height*.03/2),
                              height: customContainerHeight,
                              width: width * .8,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      containerRoundCorner)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: TextFormField(
                                    autofocus: false,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email Address',
                                      errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15),
                                    ),
                                    controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Email';
                                      } else if (!value.contains('@')) {
                                        return 'Please Enter Valid Email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: padding,
                          ),
                          Container(
                            height: customContainerHeight,
                            width: width * .8,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(containerRoundCorner),
                                color: secondaryColor),
                            child: FlatButton(
                              child: Text(
                                'Send Email',
                                style: brownSubtitleTextStyle(),
                              ),
                              //color: Constants.secondaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                // Validate returns true if the form is valid, otherwise false.
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    email = emailController.text;
                                  });
                                  resetPassword();
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: padding),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: customContainerHeight,
                                width: width * .38,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        containerRoundCorner),
                                    color: primaryColor,
                                    border: Border.all(color: primaryColor)),
                                child: FlatButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      )),
                                  child: Text(
                                    'Login',
                                    style: brownSubtitleTextStyle()
                                  ),
                                ),
                              ),
                              Container(
                                height: customContainerHeight,
                                width: width * .38,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        containerRoundCorner),
                                    color: Colors.white,
                                    border: Border.all(color: primaryColor)),
                                child: FlatButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupPage(),
                                      )),
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                        color: primaryColor),
                                  ),
                                  //color: Constants.secondaryColor,
                                  textColor: primaryColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: padding,
                          ),
                          GoogleLoginButton(
                            height: height,
                            width: width,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * .03),
                            child: GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("Already have account, "),
                                    Text(
                                      'Send Email',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )))));
  }
}


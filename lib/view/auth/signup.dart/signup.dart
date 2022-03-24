// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';
import 'package:glamourme/view/auth/login/login.dart';
import 'package:glamourme/view/widgets/custom_btn.dart';
import 'package:provider/provider.dart';

import '../../../model/google_signin.dart';
import '../../widgets/text_field_container.dart';
import '../signup.dart/signup.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool hidePassword = true;
  passwordiconOnpressed() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  registration() async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registered Successfully. Please Login..",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("Password Provided is too Weak");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: primaryColor,
              content: const Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          print("Account Already exists");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: primaryColor,
              content: const Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          );
        }
      }
    } else {
      print("Password and Confirm Password doesn't match");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: const Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Spacer(),
              ListTile(
                title: Text(
                  'Glamourme',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'we guaranteed your handsome',
                  textAlign: TextAlign.center,
                  style: subTitleTextStyle(),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: customContainerHeight,
                      //margin: const EdgeInsets.all(40),
                      width: double.infinity,
                      child: FlatButton(
                        child: const Text('Google'),
                        onPressed: () {
                          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
                        },
                        color: backgroundColor,
                        textColor: buttonTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: padding,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: customContainerHeight,
                      child: FlatButton(
                        child: const Text("Facebook"),
                        onPressed: () {},
                        color: Colors.blue[900],
                        textColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
              TextFieldContainer(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_outline,
                      color: primaryColor,
                    ),
                    hintText: "Username",
                    hintStyle: subTitleTextStyle(),
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextFieldContainer(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email_outlined,
                      color: primaryColor,
                    ),
                    hintText: "Email address",
                    hintStyle: subTitleTextStyle(),
                    border: InputBorder.none,
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
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
              TextFieldContainer(
                child: TextFormField(
                  obscureText: hidePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: subTitleTextStyle(),
                    icon: Icon(
                      Icons.lock_outline,
                      color: primaryColor,
                    ),
                    suffixIcon: IconButton(
                        color: primaryColor,
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: hidePassword ? Colors.grey : primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        }),
                    border: InputBorder.none,
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              // TODO: Un-comment to re enter password
              // TextFieldContainer(
              //   child: TextFormField(
              //     obscureText: hidePassword,
              //     textInputAction: TextInputAction.done,
              //     decoration: InputDecoration(
              //       hintText: "Confirm Password",
              //       hintStyle: subTitleTextStyle(),
              //       icon: Icon(
              //         Icons.lock_outline,
              //         color: primaryColor,
              //       ),
              //       suffixIcon: IconButton(
              //           color: primaryColor,
              //           icon: Icon(
              //             hidePassword
              //                 ? Icons.visibility_off
              //                 : Icons.visibility,
              //             color: hidePassword ? Colors.grey : primaryColor,
              //           ),
              //           onPressed: () {
              //             setState(() {
              //               hidePassword = !hidePassword;
              //             });
              //           }),
              //       border: InputBorder.none,
              //       errorStyle:
              //           TextStyle(color: Colors.redAccent, fontSize: 15),
              //     ),
              //     controller: confirmPasswordController,
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please Enter Password';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              SizedBox(
                height: padding / 2,
              ),
              CustomBtn(text: 'Register', onPress: () {
                // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                            confirmPassword = confirmPasswordController.text;
                          });
                          registration();
                        }
              }),
              SizedBox(
                height: padding,
              ),
              InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      )),
                  child: Text(
                    'Login',
                    style: subTitleTextStyle(),
                  )),
              SizedBox(
                height: height * .06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';
import 'package:glamourme/view/auth/login/login.dart';
import 'package:glamourme/view/widgets/custom_btn.dart';

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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: padding),
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
            SizedBox(height: height*.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(
                child: SizedBox(
                    height: customContainerHeight,
                    //margin: const EdgeInsets.all(40),
                    width: double.infinity,
                    child: FlatButton(
                      child: const Text(
                          'Google'),
                      onPressed: (){},
                      color: backgroundColor,
                      textColor: buttonTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ),
              SizedBox(width: padding,),
              Expanded(
      child: SizedBox(
        height: customContainerHeight,
        child: FlatButton(
          child: const Text(
              "Facebook"),
          onPressed: (){},
          color: Colors.blue[900],
          textColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    )
            ],),
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
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                obscureText: hidePassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Password", hintStyle: subTitleTextStyle(),
                  icon: Icon(
                    Icons.lock_outline,
                    color: primaryColor,
                  ),
                  suffixIcon: IconButton(
                      color: primaryColor,
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: hidePassword ? Colors.grey : primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      }),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: padding/2,),
            CustomBtn(text: 'Register', onPress: (){}),
            SizedBox(height: padding,),
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),)),
              child: Text('Login',style: subTitleTextStyle(),)),
            SizedBox(height: height*.06,),
          ],
        ),
      ),
    );
  }
}

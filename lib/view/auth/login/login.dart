import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';
import 'package:glamourme/view/navigation/bavigation_bar.dart';
import 'package:glamourme/view/widgets/custom_btn.dart';

import '../../home/home.dart';
import '../../widgets/text_field_container.dart';
import '../signup.dart/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            SizedBox(
              height: height * .1,
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
                  hintText: "Your Email",
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
            Text('Forgot Password?',style: subTitleTextStyle(),),
            SizedBox(height: padding,),
            CustomBtn(text: 'Login', onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage(),));
            }),
            SizedBox(height: padding,),
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),)),
              child: Text('Register',style: subTitleTextStyle(),)),
            SizedBox(height: height*.06,),
          ],
        ),
      ),
    );
  }
}

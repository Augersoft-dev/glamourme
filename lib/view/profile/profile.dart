import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';
import 'package:glamourme/view/auth/login/login.dart';
import 'package:glamourme/view/widgets/custom_btn.dart';
import 'package:provider/provider.dart';

import '../../model/google_signin.dart';
import '../widgets/text_field_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: blackColor),
          title: Text(
            "Profile",
            style: titleTextStyle(),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              top: height * .1,
              left: width / 2 - height * 0.08,
              child: CircleAvatar(
                radius: height * .08,
                backgroundColor: backgroundColor,
                child: const ClipOval(
                  child: SizedBox(
                    width: 170,
                    height: 170,
                    // child: _image == null
                    //     ? Image.asset(
                    //         'assets/images/placeholder.jpg',
                    //         fit: BoxFit.cover,
                    //       )
                    //     : Image.file(
                    //         _image,
                    //         fit: BoxFit.cover,
                    //       ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * .2,
              left: width / 2 - height * .14,
              right: 0,
              child: FloatingActionButton(
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.linked_camera_outlined,
                    color: whiteColor,
                  ),
                  mini: true,
                  onPressed: () {}),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * .26,
                  ),
                  ListTile(
                    title: Text(
                      "User name",
                      textAlign: TextAlign.center,
                      style: titleTextStyle(),
                    ),
                    subtitle: Text(
                      "0300000445505",
                      textAlign: TextAlign.center,
                      style: subTitleTextStyle(),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Row(children: [
                    Text(
                      'Full name',
                      style: subTitleTextStyle(),
                    )
                  ]),
                  TextFieldContainer(
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "User name",
                        hintStyle: subTitleBoldTextStyle(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(children: [
                    Text(
                      'Phone number',
                      style: subTitleTextStyle(),
                    )
                  ]),
                  TextFieldContainer(
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "0300000445505",
                        hintStyle: subTitleBoldTextStyle(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  CustomBtn(text: "Save changes", onPress: () {}),
                ],
              ),
            )
          ],
        ));
  }
}

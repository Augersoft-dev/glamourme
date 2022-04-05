import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/google_signin.dart';
import '../../utils/style.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: customContainerHeight,
      width: width * .8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(containerRoundCorner),
          color: Colors.white,
          border: Border.all(color: primaryColor)),
      child: FlatButton(
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
        },
        child: Text(
          'Login with Google',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w300, color: primaryColor),
        ),
        //color: Constants.secondaryColor,
        textColor: primaryColor,
      ),
    );
  }
}
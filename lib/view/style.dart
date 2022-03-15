

import 'dart:html';

import 'package:flutter/material.dart';

// App Colors
var primaryColor = const Color(0xFFECBB6A);
var primaryLightColor = const Color(0xFFFFE0AD);
var secondaryLightColor = const Color(0xFFD0C2A0);
var secondaryColor = const Color(0xFF877547);
var blackColor = const Color(0xFF3C3932);
var blackLightColor = const Color(0xFF808080);
var buttonTextColor = const Color(0xFF53123A);
var backgroundColor = const Color(0xFF53123A);
var whiteColor = const Color(0xFFFFFFFF);
var whiteColorWithOpacity = const Color(0xFFFFFFFF).withOpacity(0.6);



// TextStyles
splashTitleTextStyle(){
  return const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 36,
    color: Colors.white,
    fontWeight: FontWeight.bold
  );
}
buttonTextStyle(){
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: buttonTextColor,
    fontWeight: FontWeight.w600
  );
}
titleTextStyle(){
  return const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w600
  );
}
subTitleTextStyle(){
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: blackLightColor,
    fontWeight: FontWeight.w400
  );
}
subTitleBoldTextStyle(){
  return const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w600
  );
}
descriptionBlackTextStyle(){
  return const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w600
  );
}
descriptionTextStyle(){
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: blackLightColor,
    fontWeight: FontWeight.w400
  );
}
adsTextStyle(){
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: whiteColor,
    fontWeight: FontWeight.w500
  );
}
brownTitleTextStyle(){
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: secondaryColor,
    fontWeight: FontWeight.w600
  );
}
brownSubtitleTextStyle(){
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    color: secondaryColor,
    fontWeight: FontWeight.w400
  );
}



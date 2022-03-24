import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';

ThemeData customTheme() {
    final ThemeData base = ThemeData.light();
    return ThemeData(
      accentColor: secondaryLightColor,
      primaryColor: primaryColor,
      //primarySwatch: primaryColor as MaterialColor,
      buttonColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      cardColor: secondaryColor,
      errorColor: Colors.red,
      textTheme: _customTextTheme(base.textTheme),
      primaryTextTheme: _customTextTheme(base.primaryTextTheme),
      accentTextTheme: _customTextTheme(base.accentTextTheme),
    );
  }

  TextTheme _customTextTheme(TextTheme base) {
    return base
        .copyWith(
         
        )
        .apply(
          fontFamily: 'Poppins',
        );
  }

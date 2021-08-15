import 'dart:ui';
import 'package:flutter/material.dart';

final Color primaryColor = Color(0xFFFFFFFF);

final MaterialColor primarySwatch = MaterialColor(
  primaryColor.value,
  <int, Color>{
    50: Color(0xFFF7F1EC),
    100: Color(0xFFEBDBCF),
    200: Color(0xFFDDC3B0),
    300: Color(0xFFCFAB90),
    400: Color(0xFFC59978),
    500: Color(0xFFBB8760),
    600: Color(0xFFB57F58),
    700: Color(0xFFAC744E),
    800: Color(0xFFA46A44),
    900: Color(0xFF965733),
  },
);

final TextTheme myTextTheme = TextTheme(
  headline1: TextStyle(
    fontFamily: 'Red Hat Display',
    fontSize: 102,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: TextStyle(
    fontFamily: 'Red Hat Display',
    fontSize: 64,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: TextStyle(
    fontFamily: 'Red Hat Display',
    fontSize: 51,
    fontWeight: FontWeight.w400,
  ),
  headline4: TextStyle(
    fontFamily: 'Red Hat Display',
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: .25,
  ),
  headline5: TextStyle(
    fontFamily: 'Red Hat Display',
    fontSize: 25,
    fontWeight: FontWeight.w400,
  ),
  headline6: TextStyle(
    fontFamily: 'Red Hat Display',
    fontSize: 21,
    fontWeight: FontWeight.w500,
    letterSpacing: .15,
  ),
  subtitle1: TextStyle(
    fontFamily: 'Red Hat Display',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: .15,
  ),
  subtitle2: TextStyle(
    fontFamily: 'Red Hat Display',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: .1,
  ),
  bodyText1: TextStyle(
    fontFamily: 'Red Hat Text',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: .5,
  ),
  bodyText2: TextStyle(
    fontFamily: 'Red Hat Text',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: .25,
  ),
  button: TextStyle(
    fontFamily: 'Red Hat Text',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: TextStyle(
    fontFamily: 'Red Hat Text',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: .4,
  ),
  overline: TextStyle(
    fontFamily: 'Red Hat Text',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

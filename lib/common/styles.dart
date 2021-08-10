import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = Color(0xFF2962FF);

final MaterialColor blueSwatch = MaterialColor(
  primaryColor.value,
  <int, Color>{
    50: Color(0xFFE7E9FF),
    100: Color(0xFFC2C8FE),
    200: Color(0xFF96A4FE),
    300: Color(0xFF6280FF),
    400: Color(0xFF2962FF),
    500: Color(0xFF0044FC),
    600: Color(0xFF003BF0),
    700: Color(0xFF002FE3),
    800: Color(0xFF0022D9),
    900: Color(0xFF0001C0),
  },
);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.redHatDisplay(
      fontSize: 102, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.redHatDisplay(
      fontSize: 64, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3:
      GoogleFonts.redHatDisplay(fontSize: 51, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.redHatDisplay(
      fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5:
      GoogleFonts.redHatDisplay(fontSize: 25, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.redHatDisplay(
      fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.redHatDisplay(
      fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.redHatDisplay(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.redHatText(
      fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.redHatText(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.redHatText(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.redHatText(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.redHatText(
      fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color.fromARGB(255, 212, 0, 255);

Color kOrangeColor = Color.fromARGB(255, 212, 0, 255);
Color kdisableOrange = Color.fromARGB(255, 217, 182, 255);
const Color kBlackColor = Color(0xff2D2D2D);
Color kSemiBlackColor = Color(0xff595959);
const Color kGreyColor = Color.fromARGB(255, 219, 216, 216);
const Color kWhiteColor = Color(0xffFFFFFF);
Color kBackgroundColor = kWhiteColor;

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

TextStyle orangeTextStyle = GoogleFonts.nunito(
  color: kOrangeColor,
);

const TextStyle blackTextStyle = TextStyle(
  fontFamily: 'TechnaSans',
  color: kBlackColor,
);

TextStyle semiBlackTextStyle = TextStyle(
  fontFamily: 'Gordita',
  color: kSemiBlackColor,
);

const TextStyle whiteTextStyle = TextStyle(
  fontFamily: 'TechnaSans',
  color: kWhiteColor,
);

TextStyle greyTextStyle = TextStyle(
  fontFamily: 'TechnaSans',
  color: kGreyColor,
);

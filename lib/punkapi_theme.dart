import 'package:flutter/material.dart';

const kLightPrimaryColor = Color(0xFF00AFDA);

const kRobotoTextStyle = TextStyle(
  fontFamily: 'Roboto',
);

final lightTextStyle = kRobotoTextStyle.copyWith(
  color: Colors.black,
);

final darkTextStyle = kRobotoTextStyle.copyWith(
  color: Colors.white,
);

final lightTheme = ThemeData(
  primaryColor: kLightPrimaryColor,
  shadowColor: kLightPrimaryColor,
  backgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    headline5: lightTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headline6: lightTextStyle.copyWith(
      fontSize: 17,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: lightTextStyle.copyWith(
      fontSize: 13,
    ),
    bodyText1: lightTextStyle.copyWith(
      fontSize: 20,
    ),
  ),
);

final darkTheme = ThemeData(
  primaryColor: Colors.black,
  backgroundColor: Colors.black87,
  shadowColor: Colors.white,
  cardColor: kLightPrimaryColor.withOpacity(0.5),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    headline5: darkTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headline6: darkTextStyle.copyWith(
      fontSize: 17,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: darkTextStyle.copyWith(
      fontSize: 13,
    ),
    bodyText1: darkTextStyle.copyWith(
      fontSize: 22,
    ),
  ),
);

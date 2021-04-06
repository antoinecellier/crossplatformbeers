import 'package:crossplatformbeers/punkapi_theme.dart';
import 'package:crossplatformbeers/routes/homepage.dart';
import 'package:flutter/material.dart';

class PunkApiApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cross plateform Flutter App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

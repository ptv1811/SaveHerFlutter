import 'package:flutter/material.dart';
import 'Main/login.dart';

ThemeData buildTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    hintColor: Colors.red,
    primaryColor: Colors.teal,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      labelStyle: TextStyle(
        color: Colors.teal,
      ),
    ),
  );
}

void main() => runApp(MaterialApp(
  theme: buildTheme(),
  home: Login(),
  debugShowCheckedModeBanner: false,
));




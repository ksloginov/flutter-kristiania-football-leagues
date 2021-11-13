import 'dart:io';
import 'package:flutter/material.dart';

final kSelectionColor = Color(0xFFDDDDDD);
final kTintColor = Color.fromARGB(255, 0, 152, 95);
final kBackgroundColor = Color.fromARGB(255, 245, 245, 245);
final kSecondaryTexTColor = Color.fromARGB(255, 121, 121, 121);

final kAppThemeData = ThemeData.light().copyWith(
  highlightColor: kSelectionColor,
  splashColor: Platform.isIOS ? Colors.transparent : kSelectionColor,
  scaffoldBackgroundColor: kBackgroundColor,
  appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: kTintColor,
      elevation: Platform.isIOS ? 1.0 : 2.0),
);

final kLeagueColors = {42: "#162E58", 44 :"#012585", 47:"#3F1152", 50:"#15868E", 53:"#465B65", 54:"#CF353A", 55:"#213860", 73:"#000000", 87: "#003C83"};
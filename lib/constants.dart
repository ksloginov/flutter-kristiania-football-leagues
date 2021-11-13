import 'dart:io';
import 'package:flutter/material.dart';

final kSelectionColor = Color(0xFFDDDDDD);
final kTintColor = Color.fromARGB(255, 0, 152, 95);
final kBackgroundColor = Color.fromARGB(255, 245, 245, 245);

final kAppThemeData = ThemeData.light().copyWith(
  highlightColor: kSelectionColor,
  splashColor: Platform.isIOS ? Colors.transparent : kSelectionColor,
  scaffoldBackgroundColor: kBackgroundColor,
  appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: kTintColor,
      elevation: Platform.isIOS ? 1.0 : 2.0),
);


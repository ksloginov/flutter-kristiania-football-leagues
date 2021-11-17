import 'dart:io';

import 'package:flutter/material.dart';

final kFavoriteLeaguesKey = 'key_favorite_leagues';

final kStandardBackgroundColor = Color.fromARGB(255, 245, 245, 245);
final kSecondaryText = Colors.grey[500];
final kTintColor = Color.fromARGB(255, 0, 152, 95);

final kAppTheme = ThemeData.light().copyWith(
  highlightColor: Colors.greenAccent,
  splashColor: Platform.isIOS ? Colors.transparent : Color(0xFFDDDDDD),
  scaffoldBackgroundColor: kStandardBackgroundColor,
  appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: kTintColor,
      elevation: Platform.isIOS ? 1.0 : 2.0),
);

final kLeagueColors = {42: "#162E58", 44 :"#012585", 47:"#3F1152", 50:"#15868E", 53:"#465B65", 54:"#CF353A", 55:"#213860", 73:"#000000", 87: "#003C83"};
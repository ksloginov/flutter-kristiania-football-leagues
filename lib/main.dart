import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotmob/league_list_page.dart';

void main() {
  runApp(FootballApp());
}

class FootballApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        highlightColor: Color(0xFFDDDDDD),
        splashColor: Platform.isIOS ? Colors.transparent : Color(0xFFDDDDDD),
        scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 245),
        appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            color: Color.fromARGB(255, 0, 152, 95),
            elevation: Platform.isIOS ? 1.0 : 2.0),
      ),
      home: LeagueListPage(),
    );
  }
}

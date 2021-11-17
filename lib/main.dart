import 'package:flutter/material.dart';
import 'package:fotmob/league_list_page.dart';

import 'constants.dart';

void main() {
  runApp(FootballApp());
}

class FootballApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
      home: LeagueListPage(),
    );
  }
}

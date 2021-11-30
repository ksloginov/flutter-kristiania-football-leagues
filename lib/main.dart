import 'package:flutter/material.dart';
import 'package:fotmob/league_list_page.dart';
import 'package:fotmob/model/league_model.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

void main() {
  runApp(FootballApp());
}

class FootballApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return LeagueModel();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: kAppTheme,
        home: LeagueListPage(),
      ),
    );
  }
}

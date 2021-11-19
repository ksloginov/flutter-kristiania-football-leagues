import 'package:flutter/material.dart';
import 'package:fotmob/model/team.dart';

class TeamListPage extends StatelessWidget {

  final List<Team> teams;
  TeamListPage(this.teams);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
    );
  }
}

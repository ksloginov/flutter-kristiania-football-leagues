import 'package:flutter/material.dart';
import 'model/league.dart';

class LeagueDetailsPage extends StatelessWidget {
  final League league;
  LeagueDetailsPage(this.league);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${league.name}')),
      body: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}

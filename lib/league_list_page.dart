import 'package:flutter/material.dart';
import 'package:fotmob/model/league.dart';
import 'package:fotmob/view/league_card.dart';

class LeagueListPage extends StatefulWidget {
  @override
  _LeagueListPageState createState() => _LeagueListPageState();
}

class _LeagueListPageState extends State<LeagueListPage> {
  List<League> leagues = [
    League(47, "English Premier League"),
    League(42, "Champions League"),
    League(55, "La Liga"),
  ];

  Set<int> favoriteLeagues = Set();

  void _onFavoriteClicked(int id) {
    setState(() {
      if (favoriteLeagues.contains(id)) {
        favoriteLeagues.remove(id);
      } else {
        favoriteLeagues.add(id);
      }
    });
  }

  Widget _leagueCardBuilder(BuildContext context, int index) {
    return LeagueCard(
        leagues[index], favoriteLeagues.contains(leagues[index].id), () {
      _onFavoriteClicked(leagues[index].id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select League'),
        backgroundColor: Color.fromARGB(255, 4, 152, 92),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
            itemCount: leagues.length, itemBuilder: _leagueCardBuilder),
      ),
    );
  }
}

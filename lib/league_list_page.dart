import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotmob/model/league.dart';
import 'package:fotmob/view/league_card.dart';

class LeagueListPage extends StatefulWidget {
  @override
  _LeagueListPageState createState() => _LeagueListPageState();
}

class _LeagueListPageState extends State<LeagueListPage> {
  List<League> leagues = [
    League(50, "EURO"),
    League(42, "Champions League"),
    League(44, "Copa America"),
    League(73, "Europa League"),
    League(47, "Premier League"),
    League(54, "1.Bundersliga"),
    League(87, "LaLiga"),
    League(53, "Ligue 1"),
    League(55, "Serie A"),
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
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Select League'),
            )
          ];
        },
        body: ListView.builder(
            padding: const EdgeInsets.only(top: 8.0),
            itemCount: leagues.length, itemBuilder: _leagueCardBuilder,),
      ),
    );
  }
}

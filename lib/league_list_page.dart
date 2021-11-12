import 'package:flutter/material.dart';
import 'package:fotmob/league_detail_page.dart';
import 'package:fotmob/model/league.dart';

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

  Widget _listItem(BuildContext context, League league) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LeagueDetailsPage(league)));
      },
      leading: Image.network(
        'https://images.fotmob.com/image_resources/logo/leaguelogo/${league.id}.png',
        height: 32.0,
        width: 32.0,
      ),
      title: Text('${league.name}'),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            if (favoriteLeagues.contains(league.id)) {
              favoriteLeagues.remove(league.id);
            } else {
              favoriteLeagues.add(league.id);
            }
          });
        },
        child: Icon(favoriteLeagues.contains(league.id)
            ? Icons.star
            : Icons.star_border),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select League'),
        backgroundColor: Color.fromARGB(255, 4, 152, 92),
      ),
      body: ListView.builder(
          itemCount: leagues.length,
          itemBuilder: (BuildContext context, int index) {
            return _listItem(context, leagues[index]);
          }),
    );
  }
}
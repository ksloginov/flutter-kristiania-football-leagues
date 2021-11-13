import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotmob/model/league.dart';
import 'package:fotmob/model/list_item.dart';
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

  Set<int> _favoriteLeagues = Set();

  List<ListItem> _items = [];

  _LeagueListPageState() {
    _populateListItems();
  }

  void _onFavoriteClicked(int id) {
    setState(() {
      if (_favoriteLeagues.contains(id)) {
        _favoriteLeagues.remove(id);
      } else {
        _favoriteLeagues.add(id);
      }

      _populateListItems();
    });
  }

  Widget _leagueCardBuilder(BuildContext context, int index) {
    switch (_items[index].type) {
      case ListItemType.header:
        final title = _items[index].title;
        if (title == null) {
          throw Exception("Title can't be null");
        }

        return Text(title, style: Theme.of(context).textTheme.headline5,);
      case ListItemType.item:
        final league = _items[index].league;
        if (league == null) {
          throw Exception("League can't be null");
        }

        return LeagueCard(league, _favoriteLeagues.contains(league.id), () {
          _onFavoriteClicked(league.id);
        });
    }
  }

  void _populateListItems() {
    List<ListItem> newList = [];
    if (_favoriteLeagues.isNotEmpty) {
      newList.add(ListItem(type: ListItemType.header, title: "Favorites"));
      for (final league in leagues) {
        if (_favoriteLeagues.contains(league.id)) {
          newList.add(ListItem(type: ListItemType.item, league: league));
        }
      }
    }

    newList.add(ListItem(type: ListItemType.header, title: "All leagues"));
    for (final league in leagues) {
      if (!_favoriteLeagues.contains(league.id)) {
        newList.add(ListItem(type: ListItemType.item, league: league));
      }
    }

    _items = newList;
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
          itemCount: _items.length,
          itemBuilder: _leagueCardBuilder,
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotmob/constants.dart';
import 'package:fotmob/model/league.dart';
import 'package:fotmob/model/list_item.dart';
import 'package:fotmob/view/custom_header.dart';
import 'package:fotmob/view/league_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeagueListPage extends StatefulWidget {
  @override
  _LeagueListPageState createState() => _LeagueListPageState();

  final List<League> allAvailableLeagues;
  final SharedPreferences? preferences;

  LeagueListPage(this.allAvailableLeagues, this.preferences);
}

class _LeagueListPageState extends State<LeagueListPage> {
  List<League> _leagues = [];

  List<ListItem> _items = [];

  Set<int> favoriteLeagues = Set();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    final favoriteCache = widget.preferences?.getStringList(kFavoriteLeaguesKey);
    if (favoriteCache != null) {
      favoriteLeagues = favoriteCache.map((e) => int.parse(e)).toSet();
    }

    setState(() {
      _leagues = widget.allAvailableLeagues;
      _populateListItems();
    });
  }

  void _storeFavorites() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final favList = favoriteLeagues.map((e) => e.toString()).toList();
    preferences.setStringList(kFavoriteLeaguesKey, favList);
  }

  void _populateListItems() {
    List<ListItem> newList = [];

    if (favoriteLeagues.isNotEmpty) {
      newList.add(ListItem(type: ListItemType.header, title: 'Favorites'));
      for (final league in _leagues) {
        if (favoriteLeagues.contains(league.id)) {
          newList.add(ListItem(type: ListItemType.item, league: league));
        }
      }
    }

    newList.add(ListItem(type: ListItemType.header, title: 'All leagues'));
    for (final league in _leagues) {
      if (!favoriteLeagues.contains(league.id)) {
        newList.add(ListItem(type: ListItemType.item, league: league));
      }
    }

    _items = newList;
  }

  void _onFavoriteClicked(int id) {
    setState(() {
      if (favoriteLeagues.contains(id)) {
        favoriteLeagues.remove(id);
      } else {
        favoriteLeagues.add(id);
      }

      _storeFavorites();
      _populateListItems();
    });
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    switch (_items[index].type) {
      case ListItemType.header:
        final title = _items[index].title;
        if (title == null) {
          throw Exception('Oh no, empty header');
        }

        return CustomHeader(title);
      case ListItemType.item:
        final league = _items[index].league;
        if (league == null) {
          throw Exception('Oh no!');
        }

        return LeagueCard(
          league,
          favoriteLeagues.contains(league.id),
          () {
            _onFavoriteClicked(league.id);
          },
        );
    }
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
          padding: EdgeInsets.only(top: 8.0),
          itemCount: _items.length,
          itemBuilder: _listItemBuilder,
        ),
      ),
    );
  }
}

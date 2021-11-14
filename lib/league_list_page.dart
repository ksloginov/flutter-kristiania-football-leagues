import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotmob/constants.dart';
import 'package:fotmob/model/league.dart';
import 'package:fotmob/model/list_item.dart';
import 'package:fotmob/view/league_card.dart';
import 'package:fotmob/view/league_header.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final _controller = AnimatedListController();

  Set<int> _favoriteLeagues = Set();

  List<ListItem> _items = [];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final cache = prefs.getStringList(kStoredFavoritesKey)?.map((e) => int.parse(e)).toSet();
      if (cache != null) {
        _favoriteLeagues = cache;
      }

      setState(() {
        _populateListItems();
      });
    });
  }

  void _onFavoriteClicked(int id) {
    setState(() {
      if (_favoriteLeagues.contains(id)) {
        _favoriteLeagues.remove(id);
      } else {
        _favoriteLeagues.add(id);
      }

      _populateListItems();
      _storeFavorites();
    });
  }

  Widget _leagueCardBuilder(BuildContext context, ListItem item) {
    switch (item.type) {
      case ListItemType.header:
        final title = item.title;
        if (title == null) {
          throw Exception("Title can't be null");
        }

        return LeagueHeader(title);
      case ListItemType.item:
        final league = item.league;
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

  void _storeFavorites() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(kStoredFavoritesKey, _favoriteLeagues.map((e) => e.toString()).toList());
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
        body: AutomaticAnimatedListView<ListItem>(
          padding: EdgeInsets.only(top: 8.0),
          list: _items,
          comparator: AnimatedListDiffListComparator<ListItem>(
            sameItem: (a, b) => a.type == b.type && a.league == b.league && a.title == b.title,
            sameContent: (a, b) => a.type == b.type && a.league == b.league && a.title == b.title,
          ),
          itemBuilder: (context, item, data) => data.measuring
              ? Container(height: 60) : _leagueCardBuilder(context, item),
          listController: _controller,
        ),

      ),
    );
  }
}
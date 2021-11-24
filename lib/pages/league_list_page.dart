import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotmob/constants.dart';
import 'package:fotmob/model/league.dart';
import 'package:fotmob/model/list_item.dart';
import 'package:fotmob/view/custom_header.dart';
import 'package:fotmob/view/league_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class LeagueListPage extends StatefulWidget {
  @override
  _LeagueListPageState createState() => _LeagueListPageState();

  final List<League> allAvailableLeagues;
  final SharedPreferences? preferences;

  LeagueListPage(this.allAvailableLeagues, this.preferences);
}

class _LeagueListPageState extends State<LeagueListPage> {
  List<League> _suggestedLeagues = [];
  List<League> _remoteLeagues = [];
  List<ListItem> _items = [];
  Set<int> favoriteLeagues = Set();
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    final favoriteCache =
        widget.preferences?.getStringList(kFavoriteLeaguesKey);
    if (favoriteCache != null) {
      favoriteLeagues = favoriteCache.map((e) => int.parse(e)).toSet();
    }

    setState(() {
      _suggestedLeagues = widget.allAvailableLeagues;
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

    final leagues =
        _textFieldController.text.isEmpty ? _suggestedLeagues : _remoteLeagues;

    if (favoriteLeagues.isNotEmpty) {
      newList.add(ListItem(type: ListItemType.header, title: 'Favorites'));
      for (final league in leagues) {
        if (favoriteLeagues.contains(league.id)) {
          newList.add(ListItem(type: ListItemType.item, league: league));
        }
      }
    }

    newList.add(ListItem(type: ListItemType.header, title: 'All leagues'));
    for (final league in leagues) {
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

  void _search(String newValue) async {

    Future.delayed(Duration(milliseconds: 400), () async {

      if (_textFieldController.text != newValue) {
        print('Value has changed');

        if (_textFieldController.text.isEmpty) {
          setState(() {
            _populateListItems();
          });
        }
        return;
      }

      final response = await get(Uri.parse(
          '....term=$newValue'));

      if (response.statusCode != 200) {
        print('Weird http response. Possible error?');
        return;
      }

      try {
        final jsonResponse = jsonDecode(response.body);
        final jsonHits = jsonResponse['aggregations']['types']['buckets'][0]
        ['top_hits']['hits']['hits'] as Iterable<dynamic>;

        _remoteLeagues = List<League>.of(jsonHits
            .map((e) => League(int.parse(e['_id']), e['_source']['name'])));
      } catch (e) {
        print(e);
        print('Json format was wrong, stupid idiot');
      }

      setState(() {
        _populateListItems();
      });
    });
  }

  Widget _searchField() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
      child: TextField(
        controller: _textFieldController,
        onChanged: _search,
        onSubmitted: (newValue) {
          setState(() {
            _textFieldController.clear();
            _populateListItems();
          });
        },
        textInputAction: TextInputAction.search,
        autocorrect: false,
        cursorColor: kTintColor,
        decoration: InputDecoration(
            hintText: 'Filter leagues',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: kTextFieldBorder,
            focusedBorder: kTextFieldBorder,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0)),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
          color: Color.fromARGB(255, 51, 51, 51),
        ),
      ),
    );
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
        body: Column(children: [
          _searchField(),
          Expanded(
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                  FocusScope.of(context).unfocus();
                }

                return true;
              },
              child: ListView.builder(
                padding: EdgeInsets.only(top: 8.0),
                itemCount: _items.length,
                itemBuilder: _listItemBuilder,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

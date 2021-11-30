import 'package:flutter/material.dart';
import 'package:fotmob/model/league.dart';
import 'package:fotmob/model/list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LeagueModel extends ChangeNotifier {

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

  LeagueModel() {
    readFromSharedPreferences();
  }

  void readFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteLeagues = prefs.getStringList(kFavLeagues)?.map((e) => int.parse(e)).toSet() ?? Set();
    notifyListeners();
  }

  void saveToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(kFavLeagues, favoriteLeagues.map((e) => e.toString()).toList());
  }

  void toggleFavorite(League league) {
    if (favoriteLeagues.contains(league.id)) {
      favoriteLeagues.remove(league.id);
    } else {
      favoriteLeagues.add(league.id);
    }

    saveToSharedPreferences();

    notifyListeners();
  }

  bool isFavorite(League league) {
    return favoriteLeagues.contains(league.id);
  }

  List<ListItem> items() {
    List<ListItem> newList = [];
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

    return newList;
  }
}
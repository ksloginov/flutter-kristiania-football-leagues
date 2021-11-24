import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fotmob/constants.dart';
import 'package:fotmob/model/league.dart';
import 'package:fotmob/model/team.dart';
import 'package:fotmob/pages/league_list_page.dart';
import 'package:fotmob/pages/player_list_page.dart';
import 'package:fotmob/pages/team_list_page.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  bool _isLoading = true;
  int _selectedIndex = 0;

  SharedPreferences? _preferences;
  List<League> _leagues = [];
  List<Team> _teams = [];

  @override
  void initState() {
    super.initState();
    _loadSharedPresAndThenData();
  }

  void _loadSharedPresAndThenData() async {
    _preferences = await SharedPreferences.getInstance();

    final response = await get(Uri.parse('https://pub.fotmob.com/prod/pub/onboarding'),);
    if (response.body.isEmpty) {
      return;
    }

    final jsonResponse = jsonDecode(response.body);
    final jsonSuggestedLeagues = jsonResponse['suggestedLeagues'] as Iterable<dynamic>;
    final jsonSuggestedTeams = jsonResponse['suggestedTeams'] as Iterable<dynamic>;

    _leagues = List<League>.of(jsonSuggestedLeagues.map((e) => League.fromJson(e)));
    _teams = List<Team>.of(jsonSuggestedTeams.map((e) => Team.fromJson(e)));

    setState(() {
      _isLoading = false;
    });
  }

  Widget _selectedPage() {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: Text('Data is loading')),
      );
    }

    switch (_selectedIndex) {
      case 0:
        return LeagueListPage(_leagues, _preferences);
      case 1:
        return TeamListPage(_teams);
      case 2:
        return PlayerListPage();
      default:
        throw Exception('This should never happen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: kTintColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined), label: 'Leagues'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer_outlined), label: 'Teams'),
          BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined), label: 'Players')
        ],
        onTap: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
      ),
      body: _selectedPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fotmob/constants.dart';
import 'package:fotmob/pages/league_list_page.dart';
import 'package:fotmob/pages/player_list_page.dart';
import 'package:fotmob/pages/team_list_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  Widget _selectedPage() {
    switch (_selectedIndex) {
      case 0:
        return LeagueListPage();
      case 1:
        return TeamListPage();
      case 2:
        return PlayListPage();
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

import 'package:flutter/material.dart';
import 'package:fotmob/constants.dart';
import 'model/league.dart';

class LeagueDetailsPage extends StatelessWidget {
  final League league;

  LeagueDetailsPage(this.league);

  Color _headerColor() {
    //...
    final colorHexCode = kLeagueColors[league.id];
    if (colorHexCode != null) {
      final cleanedUpHex = 'ff' + colorHexCode.replaceAll('#', '');
      final appBarColor = int.tryParse(cleanedUpHex, radix: 16);
      if (appBarColor != null) {
        return Color(appBarColor);
      }
    }

    return kTintColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${league.name}'),
        backgroundColor: _headerColor(),
      ),
      body: Container(),
    );
  }
}

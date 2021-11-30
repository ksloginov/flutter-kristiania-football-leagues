import 'package:flutter/material.dart';
import 'package:fotmob/model/league.dart';
import 'package:fotmob/model/league_model.dart';
import 'package:provider/provider.dart';
import '../league_detail_page.dart';
import 'dart:io';

class LeagueCard extends StatelessWidget {

  final League league;
  LeagueCard(this.league);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: Platform.isIOS ? 0.0 : 1.0,
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Platform.isIOS ? 12.0 : 4.0)),
        contentPadding: EdgeInsets.only(left: 16.0, right: 0),
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
            Provider.of<LeagueModel>(context, listen: false).toggleFavorite(league);
          },
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Provider.of<LeagueModel>(context, listen: true).isFavorite(league)
                  ? Icons.star
                  : Icons.star_border),
            ),
          ),
        ),
      ),
    );
  }

}
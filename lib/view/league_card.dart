import 'package:flutter/material.dart';
import 'package:fotmob/model/league.dart';
import '../league_detail_page.dart';
import 'dart:io';
import 'package:fotmob/constants.dart';

class LeagueCard extends StatelessWidget {

  final League league;
  final bool isFavorite;
  final void Function() favoriteClickHandler;
  LeagueCard(this.league, this.isFavorite, this.favoriteClickHandler);

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
          onTap: favoriteClickHandler,
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(isFavorite
                  ? Icons.star
                  : Icons.star_border),
            ),
          ),
        ),
      ),
    );
  }

}
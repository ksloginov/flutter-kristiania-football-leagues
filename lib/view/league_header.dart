import 'package:flutter/material.dart';
import '../constants.dart';

class LeagueHeader extends StatelessWidget {
  LeagueHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16.0),
      height: 48.0,
      child: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
            color: kSecondaryTexTColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w700
          ),
    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fotmob/model/team.dart';
import 'package:fotmob/pages/team_detail_page.dart';

class TeamCard extends StatelessWidget {
  final Team team;

  TeamCard(this.team);

  @override
  Widget build(BuildContext context) {
    final imageSize = 48.0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.white,
      elevation: 5.0,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TeamDetailPage()));
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://images.fotmob.com/image_resources/logo/teamlogo/${team.teamId}_small.png',
                height: imageSize,
                width: imageSize,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                team.teamName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

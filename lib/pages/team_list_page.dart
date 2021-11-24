import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotmob/model/team.dart';
import 'package:fotmob/view/team_card.dart';

class TeamListPage extends StatelessWidget {
  final List<Team> teams;

  TeamListPage(this.teams);

  List<Widget> _teamCards() {
    return List<Widget>.of(teams.map((e) => TeamCard(e)));
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final doINeedBigCard = totalWidth > 500;

    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, index) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Teams'),
            )
          ];
        },
        body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: SafeArea(
            child: GridView.count(
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                padding: EdgeInsets.all(8.0),
                crossAxisCount: (totalWidth / (doINeedBigCard ? 200.0 :130.0)).toInt(),
                childAspectRatio: 1.0,
                children: _teamCards()),
          ),
        ),
      ),
    );
  }
}

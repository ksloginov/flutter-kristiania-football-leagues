import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotmob/model/league_model.dart';
import 'package:fotmob/model/list_item.dart';
import 'package:fotmob/view/custom_header.dart';
import 'package:fotmob/view/league_card.dart';
import 'package:provider/provider.dart';

class LeagueListPage extends StatelessWidget {

  Widget _listItemBuilder(BuildContext context, int index) {
    final _items = Provider.of<LeagueModel>(context).items();
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

        return LeagueCard(league);
    }
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
        body: ListView.builder(
          padding: EdgeInsets.only(top: 8.0),
          itemCount: Provider.of<LeagueModel>(context).items().length,
          itemBuilder: _listItemBuilder,
        ),
      ),
    );
  }
}

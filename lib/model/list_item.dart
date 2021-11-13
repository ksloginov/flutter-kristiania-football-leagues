import 'league.dart';

enum ListItemType {
  header,
  item,
}

class ListItem {
  ListItemType type;
  League? league;
  String? title;

  ListItem({required this.type, this.league, this.title});
}
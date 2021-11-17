
import 'league.dart';

enum ListItemType {
  header,
  item,
}

class ListItem {
  final ListItemType type;
  final League? league;
  final String? title;

  ListItem({required this.type, this.league, this.title});
}
class League {
  int id;
  String name;
  League(this.id, this.name);

  static League fromJson(dynamic json) {
    return League(json['id'], json['name']);
  }
}
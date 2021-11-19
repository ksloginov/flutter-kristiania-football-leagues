class Team {
  final int teamId;
  final String teamName;

  Team(this.teamId, this.teamName);

  static Team fromJson(dynamic json) {
    return Team(json['id'], json['name']);
  }
}
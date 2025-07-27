import 'player.dart';

class Team {
  String? name;
  List<Player> batters = [];
  List<Player> bowlers = [];
  List<Player> allRounders = [];
  List<Player> wicketKeepers = [];
  Player? captain;
  Player? viceCaptain;

  Team({required this.name});

  int get totalPoints {
    final allPlayers = [...batters, ...bowlers, ...allRounders, ...wicketKeepers];
    return allPlayers.fold(0, (sum, p) => sum + p.points);
  }

  List<Player> get allPlayers => [...batters, ...bowlers, ...allRounders, ...wicketKeepers];

  int get totalSelected => allPlayers.length;

  bool isValid() {
    return batters.length == 5 &&
        bowlers.length == 3 &&
        allRounders.length == 2 &&
        wicketKeepers.length == 1 &&
        totalPoints <= 100 &&
        captain != null &&
        viceCaptain != null &&
        captain != viceCaptain;
  }
} 
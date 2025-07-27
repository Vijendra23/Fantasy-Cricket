import 'dart:ui';
import 'package:fantasy_cricket_app/configs/provider/base_view_model.dart';
import 'package:fantasy_cricket_app/feature/team_setup/data/models/team.dart';
import 'package:flutter/material.dart';
import '../../data/models/player.dart';

class PreviewTeamViewModel extends BaseViewModel {
  Team? team;

  // Group players by role
  Map<String, List<Player>> grouped = {
    'Wicket-Keeper': [],
    'Batter': [],
    'All-rounder': [],
    'Bowler': [],
  };

  // Role display names
  Map<String, String> roleNames = {
    'Wicket-Keeper': 'Wicket Keeper',
    'Batter': 'Batsman',
    'All-rounder': 'All-Rounder',
    'Bowler': 'Bowler',
  };

  // Role colors
  Map<String, Color> roleColors = {
    'Wicket-Keeper': Colors.orange.shade100,
    'Batter': Colors.blue.shade100,
    'All-rounder': Colors.green.shade100,
    'Bowler': Colors.purple.shade100,
  };

  void addPlayersRoleWise() {
    if (team != null) {
      List<Player> players = team!.allPlayers;
      for (var p in players) {
        grouped[p.role]?.add(p);
      }
    }
  }
}

import 'package:fantasy_cricket_app/configs/di/service_locator.dart';
import 'package:fantasy_cricket_app/configs/provider/base_view_model.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/select_captain/select_captain_screen.dart';
import 'package:flutter/material.dart';

import '../../data/models/player.dart';
import '../../data/models/team.dart';

class CreateTeamViewModel extends BaseViewModel {
  final Team team = Team(name: "My Team");
  TabController? tabController;
  TickerProviderStateMixin? ticketMix;
  String selectedRole = 'Batter';

  // Expanded player pool: 11 from IND, 11 from AUS
  final List<Player> players = [
    // India (IND)
    Player(name: 'Virat Kohli', role: 'Batter', points: 10, team: 'IND'),
    Player(name: 'Rohit Sharma', role: 'Batter', points: 9, team: 'IND'),
    Player(name: 'KL Rahul', role: 'Batter', points: 8, team: 'IND'),
    Player(name: 'Shubman Gill', role: 'Batter', points: 7, team: 'IND'),
    Player(name: 'Suryakumar Yadav', role: 'Batter', points: 8, team: 'IND'),
    Player(name: 'Hardik Pandya', role: 'All-rounder', points: 9, team: 'IND'),
    Player(
        name: 'Ravindra Jadeja', role: 'All-rounder', points: 8, team: 'IND'),
    Player(name: 'Jasprit Bumrah', role: 'Bowler', points: 10, team: 'IND'),
    Player(name: 'Mohammed Shami', role: 'Bowler', points: 8, team: 'IND'),
    Player(name: 'Kuldeep Yadav', role: 'Bowler', points: 7, team: 'IND'),
    Player(name: 'MS Dhoni', role: 'Wicket-Keeper', points: 10, team: 'IND'),

    // Australia (AUS)
    Player(name: 'David Warner', role: 'Batter', points: 8, team: 'AUS'),
    Player(name: 'Steve Smith', role: 'Batter', points: 8, team: 'AUS'),
    Player(name: 'Marnus Labuschagne', role: 'Batter', points: 7, team: 'AUS'),
    Player(name: 'Travis Head', role: 'Batter', points: 7, team: 'AUS'),
    Player(name: 'Glenn Maxwell', role: 'All-rounder', points: 9, team: 'AUS'),
    Player(name: 'Marcus Stoinis', role: 'All-rounder', points: 8, team: 'AUS'),
    Player(name: 'Pat Cummins', role: 'Bowler', points: 9, team: 'AUS'),
    Player(name: 'Mitchell Starc', role: 'Bowler', points: 8, team: 'AUS'),
    Player(name: 'Adam Zampa', role: 'Bowler', points: 7, team: 'AUS'),
    Player(name: 'Alex Carey', role: 'Wicket-Keeper', points: 9, team: 'AUS'),
    Player(name: 'Josh Inglis', role: 'Wicket-Keeper', points: 8, team: 'AUS'),
  ];

  @override
  void initModel() {
    tabController?.addListener(() {
      switch (tabController?.index) {
        case 0:
          selectedRole = 'Batter';
          break;
        case 1:
          selectedRole = 'All-rounder';
          break;
        case 2:
          selectedRole = 'Bowler';
          break;
        case 3:
          selectedRole = 'Wicket-Keeper';
          break;
      }
      updateUI();
    });
    super.initModel();
  }

  void clearSelection() {
    team.batters.clear();
    team.bowlers.clear();
    team.allRounders.clear();
    team.wicketKeepers.clear();
    team.captain = null;
    team.viceCaptain = null;
    updateUI();
  }

  void togglePlayer(Player player) {
    int teamCount = team.allPlayers.where((p) => p.team == player.team).length;
    bool alreadySelected = team.allPlayers.contains(player);
    if (!alreadySelected && teamCount >= 7) {
      navigationService
          .showSnackBar('You can select max 7 players from one team.');
      return;
    }
    List<Player> roleList;
    switch (player.role) {
      case 'Batter':
        roleList = team.batters;
        if (roleList.contains(player)) {
          roleList.remove(player);
        } else if (roleList.length < 5) {
          roleList.add(player);
        }
        break;
      case 'Bowler':
        roleList = team.bowlers;
        if (roleList.contains(player)) {
          roleList.remove(player);
        } else if (roleList.length < 3) {
          roleList.add(player);
        }
        break;
      case 'All-rounder':
        roleList = team.allRounders;
        if (roleList.contains(player)) {
          roleList.remove(player);
        } else if (roleList.length < 2) {
          roleList.add(player);
        }
        break;
      case 'Wicket-Keeper':
        roleList = team.wicketKeepers;
        if (roleList.contains(player)) {
          roleList.remove(player);
        } else if (roleList.isEmpty) {
          roleList.add(player);
        }
        break;
    }
    updateUI();
  }

  void goToCaptainSelection() {
    if (team.batters.length != 5 ||
        team.allRounders.length != 2 ||
        team.bowlers.length != 3 ||
        team.wicketKeepers.length != 1 ||
        team.totalPoints > 100) {
      navigationService
          .showSnackBar('Please complete your team as per the rules.');
      return;
    }
    navigationService
        .pushScreen(SelectCaptainScreen.route.name, extra: {'team': team});
  }
}

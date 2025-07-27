import 'package:fantasy_cricket_app/configs/di/service_locator.dart';
import 'package:fantasy_cricket_app/configs/provider/base_view_model.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/preview_team/preview_team_screen.dart';
import '../../data/models/player.dart';
import '../../data/models/team.dart';

class SelectCaptainViewModel extends BaseViewModel {
  Player? captain;
  Player? viceCaptain;
  Team? team;

  void onSelectCaptain(Player player) {
    captain = player;
    if (viceCaptain == player) viceCaptain = null;
    updateUI();
  }

  void onSelectViceCaptain(Player player) {
    viceCaptain = player;
    if (captain == player) captain = null;
    updateUI();
  }

  void onConfirm() {
    if (captain == null || viceCaptain == null) {
      navigationService
          .showSnackBar('Please select both Captain and Vice-Captain.');
      return;
    }
    team?.captain = captain;
    team?.viceCaptain = viceCaptain;
    navigationService
        .pushScreen(PreviewTeamScreen.route.name, extra: {'team': team});
  }
}

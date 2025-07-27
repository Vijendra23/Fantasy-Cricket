import 'package:fantasy_cricket_app/core/extensions/string_extensions.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/preview_team/preview_team_view_model.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/preview_team/widgets/player_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../configs/di/service_locator.dart';
import '../../../../configs/provider/provider_view.dart';
import '../../../../configs/services/navigation/navigation_service_impl.dart';
import '../../data/models/player.dart';
import '../../data/models/team.dart';

class PreviewTeamScreen extends ProviderView<PreviewTeamViewModel> {
  static final RouteDetails route =
      RouteDetails('player_preview', '/player_preview');

  final Team team;

  const PreviewTeamScreen({super.key, required this.team});

  @override
  void onViewModelReady(PreviewTeamViewModel viewModel) {
    viewModel.team = team;
    viewModel.addPlayersRoleWise();
  }

  @override
  Widget builder(
      BuildContext context, PreviewTeamViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: 'Team Preview'.toText(
            color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20.sp),
        leading: IconButton(
            onPressed: () {
              navigationService.pop();
            },
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white)),
      ),
      body: Column(
        children: [
          // Stylish header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team.name ?? 'My Team',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.emoji_events,
                        color: Colors.amber, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      'Total Points: ${team.totalPoints}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: viewModel.grouped.entries
                  .where((e) => e.value.isNotEmpty)
                  .map((entry) {
                String role = entry.key;
                List<Player> rolePlayers = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4),
                      child: Text(
                        viewModel.roleNames[role]!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: rolePlayers.map((player) {
                        bool isCaptain = player == team.captain;
                        bool isViceCaptain = player == team.viceCaptain;
                        return PlayerPreviewCard(
                          player: player,
                          isCaptain: isCaptain,
                          isViceCaptain: isViceCaptain,
                          color: viewModel.roleColors[role]!,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PreviewTeamViewModel viewModelBuilder(BuildContext context) {
    return PreviewTeamViewModel();
  }
}

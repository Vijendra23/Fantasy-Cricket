import 'package:fantasy_cricket_app/core/extensions/string_extensions.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/select_captain/select_captain_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../configs/constants/app_colors.dart';
import '../../../../configs/di/service_locator.dart';
import '../../../../configs/provider/provider_view.dart';
import '../../../../configs/services/navigation/navigation_service_impl.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../data/models/team.dart';

class SelectCaptainScreen extends ProviderView<SelectCaptainViewModel> {
  static final RouteDetails route =
      RouteDetails('select_captain', '/select_captain');

  final Team team;

  const SelectCaptainScreen({super.key, required this.team});

  @override
  void onViewModelReady(SelectCaptainViewModel viewModel) {
    viewModel.team = team;
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, SelectCaptainViewModel viewModel, Widget? child) {
    final players = team.allPlayers;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: 'Select Captain & Vice-Captain'.toText(
            color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20.sp),
        leading: IconButton(
            onPressed: () {
              navigationService.pop();
            },
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: players.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final player = players[index];
                  final isCaptain = viewModel.captain == player;
                  final isViceCaptain = viewModel.viceCaptain == player;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: player.team == 'IND'
                          ? Colors.blue
                          : Colors.amber[800],
                      child: Text(player.team,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    title: Text(player.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${player.role} • ${player.points} pts'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ChoiceChip(
                          label: const Text('C'),
                          selected: isCaptain,
                          selectedColor: Colors.green,
                          onSelected: (_) => viewModel.onSelectCaptain(player),
                          labelStyle: TextStyle(
                            color: isCaptain ? Colors.white : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.green),
                        ),
                        8.horizontalSpace,
                        ChoiceChip(
                          label: const Text('VC'),
                          selected: isViceCaptain,
                          selectedColor: Colors.blue,
                          onSelected: (_) =>
                              viewModel.onSelectViceCaptain(player),
                          labelStyle: TextStyle(
                            color: isViceCaptain ? Colors.white : Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: AppButton(
          textColor: AppColors.blackColor.withOpacity(0.8),
          action: () async {
            viewModel.onConfirm();
          },
          title: 'Preview Team'.toUpperCase(),
        ),
      ),
    );
  }

  @override
  SelectCaptainViewModel viewModelBuilder(BuildContext context) {
    return SelectCaptainViewModel();
  }
}

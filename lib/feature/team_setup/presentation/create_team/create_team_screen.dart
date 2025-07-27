import 'package:fantasy_cricket_app/configs/constants/app_colors.dart';
import 'package:fantasy_cricket_app/configs/di/service_locator.dart';
import 'package:fantasy_cricket_app/core/data_source/shared_preferences/preference_key.dart';
import 'package:fantasy_cricket_app/core/extensions/string_extensions.dart';
import 'package:fantasy_cricket_app/feature/auth/presentation/login/login_screen.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/create_team/create_team_view_model.dart';
import 'package:fantasy_cricket_app/feature/team_setup/presentation/create_team/widgets/player_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../configs/provider/provider_view.dart';
import '../../../../configs/services/navigation/navigation_service_impl.dart';
import '../../../../core/widgets/buttons/app_button.dart';

class CreateTeamScreen extends ProviderView<CreateTeamViewModel> {
  static final RouteDetails route = RouteDetails('create_team', '/create_team');

  const CreateTeamScreen({super.key});

  @override
  void onViewModelReady(CreateTeamViewModel viewModel) {
    viewModel.tabController =
        TabController(length: 4, vsync: viewModel.ticketMix!);
    viewModel.initModel();
    super.onViewModelReady(viewModel);
  }

  @override
  void tickerProviderStateMixin(CreateTeamViewModel viewModel,
      TickerProviderStateMixin<StatefulWidget> tickerProviderStateMixin) {
    viewModel.ticketMix = tickerProviderStateMixin;
    super.tickerProviderStateMixin(viewModel, tickerProviderStateMixin);
  }

  @override
  Widget builder(
      BuildContext context, CreateTeamViewModel viewModel, Widget? child) {
    int indCount =
        viewModel.team.allPlayers.where((p) => p.team == 'IND').length;
    int ausCount =
        viewModel.team.allPlayers.where((p) => p.team == 'AUS').length;
    // Tab labels with selected count
    final roleTabs = [
      Tab(text: 'Batters (${viewModel.team.batters.length}/5)'),
      Tab(text: 'All-rounders (${viewModel.team.allRounders.length}/2)'),
      Tab(text: 'Bowlers (${viewModel.team.bowlers.length}/3)'),
      Tab(text: 'Wicket-Keepers (${viewModel.team.wicketKeepers.length}/1)'),
    ];
    final filteredPlayers = viewModel.players
        .where((p) => p.role == viewModel.selectedRole)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: 'Create Team'.toText(
            color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20.sp),
        actions: [
          IconButton(
              onPressed: () {
                sharedPreferencesService.addBoolean(
                    PreferenceKeys.isUserLoggedIn, false);
                navigationService.goToRoute(LoginScreen.route.name);
              },
              icon: const Icon(Icons.logout, color: Colors.white))
        ],
      ),
      body: Column(
        children: [
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // 20% opacity
                    offset: const Offset(0, 2), // X: 0, Y: 2
                    blurRadius: 4.r,
                    spreadRadius: 0,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _summaryColumn(
                      'Points Used', '${viewModel.team.totalPoints}/100'),
                  16.horizontalSpace,
                  _summaryColumn(
                      'Players', '${viewModel.team.allPlayers.length}/11'),
                  16.horizontalSpace,
                  _summaryColumn('IND', '$indCount', color: Colors.blue),
                  16.horizontalSpace,
                  _summaryColumn('AUS', '$ausCount', color: Colors.amber[800]),
                ],
              ),
            ),
          ),
          15.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: viewModel.team.allPlayers.length / 11.0,
                        child: Container(
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: AppColors.orangeTextColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${viewModel.team.allPlayers.length}/11',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            shadows: const [
                              Shadow(color: Colors.black26, blurRadius: 2)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                12.horizontalSpace,
                InkWell(
                  onTap: () {
                    viewModel.clearSelection();
                  },
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.clear, color: Colors.red, size: 20),
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
          // Tab bar
          TabBar(
            controller: viewModel.tabController,
            tabs: roleTabs,
            tabAlignment: TabAlignment.center,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.blue,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
            unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          10.verticalSpace,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ListView.builder(
                itemCount: filteredPlayers.length,
                itemBuilder: (context, index) {
                  final player = filteredPlayers[index];
                  return PlayerCard(
                    player: player,
                    selected: viewModel.team.allPlayers.contains(player),
                    onTap: () => viewModel.togglePlayer(player),
                    showAddRemove: true,
                  );
                },
              ),
            ),
          ),
          10.verticalSpace,
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: AppButton(
          textColor: AppColors.blackColor.withOpacity(0.8),
          action: () async {
            viewModel.goToCaptainSelection();
          },
          title: 'Next'.toUpperCase(),
        ),
      ),
    );
  }

  Widget _summaryColumn(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            style:
                TextStyle(fontSize: 12.sp, color: color ?? Colors.grey[600])),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16.sp, color: color)),
      ],
    );
  }

  @override
  CreateTeamViewModel viewModelBuilder(BuildContext context) {
    return CreateTeamViewModel();
  }
}

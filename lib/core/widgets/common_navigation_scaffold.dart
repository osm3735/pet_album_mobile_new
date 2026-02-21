import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';

class CommonNavigationScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CommonNavigationScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,

          iconTheme: WidgetStateProperty.resolveWith(
                (states) => IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? AppColors.fMain
                  : AppColors.f02,
            ),
          ),

          labelTextStyle: WidgetStateProperty.resolveWith(
                (states) => AppTextStyle.caption12R140.copyWith(
              color: states.contains(WidgetState.selected)
                  ? AppColors.fMain
                  : AppColors.f02,
              fontSize: 12,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: AppColors.white,
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_outlined),
              label: '홈',
            ),
            NavigationDestination(
              icon: Icon(Icons.photo_album_outlined),
              selectedIcon: Icon(Icons.photo_album_outlined),
              label: '앨범',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person_outline),
              label: '마이페이지',
            ),

          ],
        ),
      ),
    );
  }
}

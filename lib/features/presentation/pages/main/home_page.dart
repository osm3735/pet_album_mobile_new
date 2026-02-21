import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_button_theme.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/widgets/common_app_bar_main_scaffold.dart';
import 'package:petAblumMobile/features/presentation/pages/main/alram.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_list.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.f01,
      appBar: CommonMainAppBar(
        title: '',
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => const AlarmPage(),
            ),
            );},
          ),
          IconButton(icon: const Icon(Icons.apps), onPressed: () {}),
        ],
      ),
      body : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Family Home',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 16),

              // 예시 콘텐츠
              Expanded(
                child: Center(
                  child: Text(
                    '여기가 패밀리 홈 화면',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

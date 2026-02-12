import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/widgets/common_app_bar_main_scaffold.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.f01,
      appBar: CommonMainAppBar(
        title: '마이페이지',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: SizedBox(),
      ),
    );
  }
}

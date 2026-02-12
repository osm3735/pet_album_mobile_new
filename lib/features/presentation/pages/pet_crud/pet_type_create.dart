import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_button_theme.dart';
import 'package:petAblumMobile/core/widgets/common_app_back_bar_scaffold.dart';

import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_info_form.dart';

class PetTypCreatePage extends StatelessWidget {
  const PetTypCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonBackAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 16),
            _TitleText(),
            _PetTypeRow(),
          ],
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '어떤 반려동물을\n키우고 계신가요?',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.42,
        color: AppColors.f01,
      ),
    );
  }
}

/// 반려동물 선택 Row
class _PetTypeRow extends StatelessWidget {
  const _PetTypeRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PetTypeCard(
            label: '강아지',
            onTap: _noop,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _PetTypeCard(
            label: '고양이',
            onTap: _noop,
          ),
        ),
      ],
    );
  }

  static void _noop() {}
}

/// 반려동물 선택 카드
class _PetTypeCard extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PetTypeCard({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 207,
        padding: const EdgeInsets.fromLTRB(57, 12, 57, 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.f01, // #E0E0E0
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PetInfoEditor(),
                  ),
                );
              },
              child:Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.f01,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

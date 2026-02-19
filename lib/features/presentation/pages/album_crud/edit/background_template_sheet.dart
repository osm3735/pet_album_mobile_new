import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/color_select_scale.dart';

class BackgroundTabletPanel extends StatefulWidget {
  final VoidCallback onClose;
  final ValueChanged<Color?>? onColorChanged;
  final Color? selectedColor;

  const BackgroundTabletPanel({
    super.key,
    required this.onClose,
    this.onColorChanged,
    this.selectedColor
  });

  @override
  State<BackgroundTabletPanel> createState() =>
      _BackgroundTabletPanelState();
}

class _BackgroundTabletPanelState
    extends State<BackgroundTabletPanel> {
  int selectedTabIndex = 1;
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHandle(),
          _buildHeader(),
          const SizedBox(height: 16),
          _buildTabs(),
          const SizedBox(height: 16),
          _buildColorSection(),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 16),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '배경 템플릿',
            style: AppTextStyle.body16M120.copyWith(
              color: AppColors.fontStrong,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: widget.onClose,
            icon: const Icon(Icons.close),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildTab(0, '사진추가'),
          const SizedBox(width: 8),
          _buildTab(1, '무지'),
          const SizedBox(width: 8),
          _buildTab(2, '모눈종이'),
          const SizedBox(width: 8),
          _buildTab(3, '글종이'),
        ],
      ),
    );
  }

  Widget _buildColorSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ColorSelectorSection(
        selectedColor: selectedColor,
        onChanged: (color) {
          setState(() => selectedColor = color);
          widget.onColorChanged?.call(color);
        },
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = selectedTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min, // 추가
        children: [
          if (index == 0)
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                dashPattern: const [4, 4],
                strokeWidth: 1,
                radius: const Radius.circular(8),
                color: AppColors.gray300,
                padding: EdgeInsets.zero,
              ),
              child: const SizedBox(
                width: 72,
                height: 72,
                child: Icon(Icons.add),
              ),
            )
          else
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFBBC05)
                      : AppColors.gray300,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: SizedBox(
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyle.body12M120.copyWith(
              color: isSelected
                  ? AppColors.fontStrong
                  : AppColors.fontHint,
            ),
          ),
        ],
      ),
    );
  }
}
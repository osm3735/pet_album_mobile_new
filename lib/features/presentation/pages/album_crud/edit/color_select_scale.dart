import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/color_pickup_sheet.dart';

class ColorSelectorSection extends StatelessWidget {
  final Color? selectedColor;
  final ValueChanged<Color> onChanged;

  const ColorSelectorSection({
    super.key,
    required this.selectedColor,
    required this.onChanged,
  });

  static List<Color> colors = [
    const Color(0xFFBDBDBD),
    const Color(0xFFFF5252),
    const Color(0xFFFF6B35),
    const Color(0xFFFBBC05),
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '색상',
          style: AppTextStyle.body16M120.copyWith(
            color: AppColors.f01,
          ),
        ),
        const SizedBox(height: 20),

        Row(
          children: List.generate(colors.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _buildColorButton(
                context,
                colors[index],
                isAddButton: index == 0,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildColorButton(
      BuildContext context,
      Color color, {
        bool isAddButton = false,
      }) {
    final isSelected = selectedColor == color;

    return GestureDetector(
      onTap: () async {
        if (!isAddButton) {
          onChanged(color);
          return;
        }

        final pickedColor = await showModalBottomSheet<Color>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const ColorPickerBottomSheet(),
        );

        if (pickedColor != null) {
          onChanged(pickedColor);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isSelected)
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFBBC05),
                  width: 2,
                ),
              ),
            ),

          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: isAddButton
                ? const Icon(Icons.add, color: Colors.white, size: 20)
                : null,
          ),
        ],
      ),
    );
  }
}

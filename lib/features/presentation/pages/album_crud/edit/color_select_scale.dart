import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/color_pickup_sheet.dart';

class ColorSelectorSection extends StatefulWidget {
  final Color? selectedColor;
  final ValueChanged<Color> onChanged;

  static List<Color> color_list = [
    const Color(0xFFFF5252),
    const Color(0xFFFF6B35),
    const Color(0xFFFBBC05),
  ];

  const ColorSelectorSection({
    super.key,
    required this.selectedColor,
    required this.onChanged,
  });

  @override
  State<ColorSelectorSection> createState() => _ColorSelectorSectionState();
}

class _ColorSelectorSectionState extends State<ColorSelectorSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '색상',
          style: AppTextStyle.body16M120.copyWith(
            color: AppColors.fontStrong,
          ),
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _buildAddButton(context),
            ),
            ...List.generate(ColorSelectorSection.color_list.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildColorButton(
                  context,
                  ColorSelectorSection.color_list[index],
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedColor = await ColorPickerBottomSheet.show(
          context,
          onColorAdded: (color) {
            setState(() {
              if (!ColorSelectorSection.color_list.contains(color)) {
                ColorSelectorSection.color_list.add(color);
              }
            });
          },
        );

        if (pickedColor != null) {
          widget.onChanged(pickedColor);
        }
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFBDBDBD),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 2,
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildColorButton(
      BuildContext context,
      Color color,
      ) {
    final isSelected = widget.selectedColor == color;

    return GestureDetector(
      onTap: () {
        widget.onChanged(color);
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
          ),
        ],
      ),
    );
  }
}
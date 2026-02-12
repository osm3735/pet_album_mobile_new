import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/color_select_scale.dart';

/// 그리기 도구 패널 (토글 방식)
class DrawingToolPanel extends StatefulWidget {
  final Function(String lineStyle, double lineWidth, Color color) onSettingsChanged;
  final VoidCallback onClose;

  const DrawingToolPanel({
    Key? key,
    required this.onSettingsChanged,
    required this.onClose,
  }) : super(key: key);

  @override
  State<DrawingToolPanel> createState() => _DrawingToolPanelState();
}

class _DrawingToolPanelState extends State<DrawingToolPanel> {
  String selectedLineStyle = '실선';
  double lineWidth = 4;
  Color? selectedColor;

  final List<String> lineStyles = ['실선', '점선', '파선'];

  @override
  void initState() {
    super.initState();
    selectedColor = ColorSelectorSection.colors.isNotEmpty
        ? ColorSelectorSection.colors[0]
        : const Color(0xFFFF5252);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifyChanges();
    });
  }

  void _notifyChanges() {
    widget.onSettingsChanged(selectedLineStyle, lineWidth, selectedColor!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildLineStyleDropdown(),
          const SizedBox(height: 24),
          _buildLineWidthSlider(),
          const SizedBox(height: 16),
          ColorSelectorSection(
            selectedColor: selectedColor,
            onChanged: (color) {
              setState(() {
                selectedColor = color;
              });
              _notifyChanges();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '그리기',
          style: AppTextStyle.body16M120.copyWith(
            color: AppColors.f01,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          color: AppColors.f01,
          onPressed: widget.onClose,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildLineStyleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '선 스타일',
          style: AppTextStyle.body16M120.copyWith(
            color: AppColors.f01,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.f01,
                width: 1,
              ),
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedLineStyle,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.f01),
            items: lineStyles.map((style) {
              return DropdownMenuItem(
                value: style,
                child: Text(
                  style,
                  style: AppTextStyle.body16M120.copyWith(
                    color: AppColors.f01,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedLineStyle = value;
                });
                _notifyChanges();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLineWidthSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '선 두께',
          style: AppTextStyle.body16M120.copyWith(
            color: AppColors.f01,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              color: AppColors.f01,
              onPressed: _decreaseLineWidth,
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter, // 중앙 정렬
                children: [
                  // 선 두께 값 표시 (슬라이더 위)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${lineWidth.round()}',
                      style: AppTextStyle.body16R120.copyWith(
                        color: AppColors.f01,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // 슬라이더
                  Padding(
                    padding: const EdgeInsets.only(top: 24), // 텍스트 공간 확보
                    child: SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: AppColors.f01,
                        inactiveTrackColor: AppColors.f01,
                        thumbColor: AppColors.f01,
                        overlayColor: AppColors.f01.withOpacity(0.2),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                        trackHeight: 4,
                        showValueIndicator: ShowValueIndicator.never, // 기본 라벨 숨김
                      ),
                      child: Slider(
                        value: lineWidth,
                        min: 1,
                        max: 20,
                        divisions: 19,
                        onChanged: (value) {
                          setState(() {
                            lineWidth = value;
                          });
                          _notifyChanges();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              color: AppColors.f01,
              onPressed: _increaseLineWidth,
            ),
          ],
        ),
      ],
    );
  }

  void _decreaseLineWidth() {
    if (lineWidth > 1) {
      setState(() {
        lineWidth--;
      });
      _notifyChanges();
    }
  }

  void _increaseLineWidth() {
    if (lineWidth < 20) {
      setState(() {
        lineWidth++;
      });
      _notifyChanges();
    }
  }
}
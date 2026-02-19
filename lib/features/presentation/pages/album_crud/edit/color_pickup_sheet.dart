import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/color_select_scale.dart';

/// 색상 선택 바텀시트
class ColorPickerBottomSheet extends StatefulWidget {
  final Function(Color) onColorAdded;
  const ColorPickerBottomSheet({
    Key? key,
    required this.onColorAdded,
  }) : super(key: key);

  @override
  State<ColorPickerBottomSheet> createState() => _ColorPickerBottomSheetState();

  /// 바텀시트를 표시하는 헬퍼 메서드
  static Future<Color?> show(BuildContext context, {required Function(Color) onColorAdded} ) {
    return showModalBottomSheet<Color>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent, // 배경 완전 투명
      builder: (context) => ColorPickerBottomSheet(
        onColorAdded: onColorAdded,
      ),
    );
  }
}

class _ColorPickerBottomSheetState extends State<ColorPickerBottomSheet> {
  Color? selectedColor;
  final TextEditingController hexController = TextEditingController();

  // 색상 팔레트 생성
  List<List<Color>> _generateColorPalette() {
    final List<List<Color>> palette = [];

    // 색상 행 수 (밝기 레벨)
    final int rows = 10;
    // 색상 열 수 (색조)
    final int cols = 16;

    for (int row = 0; row < rows; row++) {
      List<Color> rowColors = [];

      for (int col = 0; col < cols; col++) {
        double hue = (col / cols) * 360;

        // 첫 번째 열은 그레이스케일
        if (col == 0) {
          double gray = row / (rows - 1);
          rowColors.add(Color.fromRGBO(
            (gray * 255).round(),
            (gray * 255).round(),
            (gray * 255).round(),
            1.0,
          ));
        } else {
          // 밝기 조정: 첫 행은 어둡게, 점진적으로 밝게
          double saturation = 1.0;
          double lightness;

          if (row == 0) {
            lightness = 0.15; // 첫 행: 매우 어두움
          } else if (row == 1) {
            lightness = 0.30; // 두 번째 행: 어두움
          } else {
            // 나머지 행: 점진적으로 밝아짐
            lightness = 0.30 + ((row - 1) / (rows - 2)) * 0.65;
          }

          rowColors.add(_hslToColor(hue, saturation, lightness));
        }
      }

      palette.add(rowColors);
    }

    return palette;
  }

  // HSL을 Color로 변환
  Color _hslToColor(double h, double s, double l) {
    h = h / 360;

    double r, g, b;

    if (s == 0) {
      r = g = b = l;
    } else {
      double hue2rgb(double p, double q, double t) {
        if (t < 0) t += 1;
        if (t > 1) t -= 1;
        if (t < 1 / 6) return p + (q - p) * 6 * t;
        if (t < 1 / 2) return q;
        if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
        return p;
      }

      double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      double p = 2 * l - q;

      r = hue2rgb(p, q, h + 1 / 3);
      g = hue2rgb(p, q, h);
      b = hue2rgb(p, q, h - 1 / 3);
    }

    return Color.fromRGBO(
      (r * 255).round(),
      (g * 255).round(),
      (b * 255).round(),
      1.0,
    );
  }

  // HEX 값으로부터 색상 업데이트
  void _updateColorFromHex(String hexValue) {
    hexValue = hexValue.replaceAll('#', '').trim();

    if (hexValue.length == 6) {
      try {
        final color = Color(int.parse('FF$hexValue', radix: 16));
        setState(() {
          selectedColor = color;
        });
      } catch (e) {
        // 잘못된 HEX 값
      }
    }
  }

  // 색상을 HEX 문자열로 변환
  String _colorToHex(Color color) {
    return '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  }

  @override
  void dispose() {
    hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = _generateColorPalette();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 상단 인디케이터
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 색상추가 / 취소 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 중앙 제목
                  Text(
                    '색상추가',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // 오른쪽 취소 버튼
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 색상 팔레트 영역
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 색상 그리드
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        children: colorPalette.map((row) {
                          return Row(
                            children: row.map((color) {
                              final isSelected = selectedColor == color;

                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = color;
                                      hexController.text = _colorToHex(color);
                                    });
                                  },
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        border: isSelected
                                            ? Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        )
                                            : null,
                                      ),
                                      child: isSelected
                                          ? Center(
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 하단 버튼 영역
                  Row(
                    children: [
                      // 프리셋 추가 버튼 (선택된 색상으로 표시)
                      GestureDetector(
                        onTap: () {
                          if (selectedColor != null) {
                            widget.onColorAdded(selectedColor!);
                            Navigator.of(context).pop(selectedColor);
                          }
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: selectedColor ?? const Color(0xFFBDBDBD),
                            shape: BoxShape.circle,
                            // 내부 밝은 테두리 (명도 높은 효과)
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white.withOpacity(0.9),
                            size: 20,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // 스포이드 버튼
                      GestureDetector(
                        onTap: () {
                          // 스포이드 로직
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.colorize_outlined,
                            color: Colors.grey[600],
                            size: 18,
                          ),
                        ),
                      ),

                      const Spacer(),

                      // HEX 입력 필드 (오른쪽 끝)
                      Container(
                        width: 123,
                        height: 33,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'HEX:',
                              style: AppTextStyle.description14R120.copyWith(
                                color: AppColors.fontPrimary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: hexController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '263EDF',
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                                style: AppTextStyle.description14R120.copyWith(
                                  color: AppColors.fontPrimary,
                                ),
                                onChanged: _updateColorFromHex,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
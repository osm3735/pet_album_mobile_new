import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/widgets/common_app_bar_main_scaffold.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/album_icon_button_list_box.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/background_template_sheet.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/drawing_tool_sheet.dart';


class AlbumEditFormPage extends StatefulWidget {
  const AlbumEditFormPage({super.key});

  @override
  State<AlbumEditFormPage> createState() => _AlbumEditFormPageState();
}

class _AlbumEditFormPageState extends State<AlbumEditFormPage> {
  bool _isInitialState = true;
  bool _showBackgroundPanel = false;
  bool _showDrawingPanel = false;

  List<DrawingPoint?> drawingPoints = [];
  String currentLineStyle = '실선';
  double currentLineWidth = 4;
  Color currentColor = const Color(0xFFBDBDBD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonMainAppBar(
        leadingPadding: const EdgeInsets.only(left: 20),
        leadingContent: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              visualDensity: VisualDensity.compact,
              icon: SvgPicture.asset(
                'assets/system/icons/undo.svg',
                width: 24,
                height: 24,
              ),
              onPressed: () {},
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              visualDensity: VisualDensity.compact,
              icon: SvgPicture.asset(
                'assets/system/icons/redo.svg',
                width: 24,
                height: 24,
              ),
              onPressed: () {},
            ),
          ],
        ),
        title: '새로운 앨범',
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('취소',
              style: AppTextStyle.body16M120.copyWith(
                color: AppColors.f01,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('완료',
              style: AppTextStyle.body16M120.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          /// 메인 컨텐츠
          Column(
            children: [
              if (_isInitialState)
                Expanded(
                  child: SafeArea(
                    child: _first(),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 114),
                child: Text(
                  '아래로 스크롤해서 앨범을 꾸며주세요.',
                  style: AppTextStyle.body16M140.copyWith(
                    color: AppColors.f01,
                  ),
                ),
              ),
            ],
          ),

          /// 배경 템플릿 패널 ← 첫 번째
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            left: 0,
            right: 0,
            bottom: _showBackgroundPanel ? 100 : -350,  // _showBackgroundPanel 사용
            child: BackgroundTabletPanel(  // BackgroundTabletPanel
              onClose: () {
                setState(() {
                  _showBackgroundPanel = false;
                });
              },
              onColorChanged: (color) {
                print('Selected color: $color');
              },
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            left: 0,
            right: 0,
            bottom: _showDrawingPanel ? 100 : -450,
            child: DrawingToolPanel(
              onSettingsChanged: (style, width, color) {
                setState(() {
                  currentLineStyle = style;
                  currentLineWidth = width;
                  currentColor = color;
                });
              },
              onClose: () {
                setState(() {
                  _showDrawingPanel = false;
                });
              },
            ),
          ),

          /// 하단 고정 아이콘바
          Positioned(
            left: 0,
            right: 0,
            bottom: 52,
            child: Center(
              child: EditorIconBar(
                onBackgroundPressed: () {
                  setState(() {
                    _showBackgroundPanel = !_showBackgroundPanel;
                    if (_showBackgroundPanel) _showDrawingPanel = false;
                  });
                },
                onDrawPressed: () { // 여기만 수정!
                  setState(() {
                    _showDrawingPanel = !_showDrawingPanel;
                    if (_showDrawingPanel) _showBackgroundPanel = false;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _first() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = width * 4 / 3;

                return DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    dashPattern: [6, 4],
                    strokeWidth: 1.5,
                    radius: Radius.circular(16),
                    color: AppColors.f01,
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: width,
                    height: height,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '표지 영역입니다.\n앨범의 표지를 꾸며주세요!',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.body16M140.copyWith(
                        color: AppColors.f01,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class DrawingPoint {
  final Offset offset;
  final Paint paint;

  DrawingPoint({required this.offset, required this.paint});
}

// 커스텀 페인터
class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;

  DrawingPainter({required this.drawingPoints});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length - 1; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(
          drawingPoints[i]!.offset,
          drawingPoints[i + 1]!.offset,
          drawingPoints[i]!.paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
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
  bool _isDrawingMode = false;

  EditorState _current = EditorState();
  List<EditorState> _history = [];
  List<EditorState> _redoStack = [];

  String currentLineStyle = '실선';
  double currentLineWidth = 4;
  Color currentColor = const Color(0xFFBDBDBD);

  void _applyState(EditorState newState) {
    setState(() {
      _history.add(_current);
      _redoStack.clear();
      _current = newState;
      _isInitialState = false;
    });
  }

  void _undo() {
    if (_history.isEmpty) return;
    setState(() {
      _redoStack.add(_current);
      _current = _history.last;
      _history.removeLast();
      _isInitialState = _current.drawingPoints.isEmpty
          && _current.background.color == null
          && _current.background.image == null;
    });
  }

  void _redo() {
    if (_redoStack.isEmpty) return;
    setState(() {
      _history.add(_current);
      _current = _redoStack.last;
      _redoStack.removeLast();
      _isInitialState = _current.drawingPoints.isEmpty
          && _current.background.color == null
          && _current.background.image == null;
    });
  }

  void _saveToHistory() {
    _history.add(_current);
    _redoStack.clear();
  }

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
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
              visualDensity: VisualDensity.compact,
              icon: SvgPicture.asset(
                'assets/system/icons/undo.svg',
                width: 24,
                height: 24,
              ),
              onPressed: _history.isEmpty ? null : _undo,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
              visualDensity: VisualDensity.compact,
              icon: SvgPicture.asset(
                'assets/system/icons/redo.svg',
                width: 24,
                height: 24,
              ),
              onPressed: _redoStack.isEmpty ? null : _redo,
            ),
          ],
        ),
        title: '새로운 앨범',
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              '취소',
              style: AppTextStyle.body16M120.copyWith(color: AppColors.gray700),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              '완료',
              style: AppTextStyle.body16M120.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 배경 레이어
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: _current.background.color,
                image: _current.background.image != null
                    ? DecorationImage(
                  image: _current.background.image!,
                  fit: BoxFit.cover,
                )
                    : null,
              ),
            ),
          ),

          // 메인 컨텐츠
          Column(
            children: [
              if (_isInitialState)
                Expanded(
                  child: SafeArea(child: _first()),
                ),
              if (!_isInitialState)
                Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(bottom: 114),
                child: Text(
                  '아래로 스크롤해서 앨범을 꾸며주세요.',
                  style: AppTextStyle.body16M140.copyWith(
                    color: AppColors.fontSecondary,
                  ),
                ),
              ),
            ],
          ),

          // 그림 그리기
          if (_isDrawingMode || _current.drawingPoints.isNotEmpty)
            Positioned.fill(
              child: GestureDetector(
                onPanStart: (details) {
                  _applyState(_current.copyWith(
                    drawingPoints: [
                      ..._current.drawingPoints,
                      DrawingPoint(
                        offset: details.localPosition,
                        paint: Paint()
                          ..color = currentColor
                          ..strokeWidth = currentLineWidth
                          ..strokeCap = StrokeCap.round
                          ..strokeJoin = StrokeJoin.round
                          ..style = currentLineStyle == '실선'
                              ? PaintingStyle.stroke
                              : PaintingStyle.fill,
                      ),
                    ],
                  ));
                },

                onPanUpdate: (details) {
                  setState(() {
                    _current = _current.copyWith(
                      drawingPoints: [
                        ..._current.drawingPoints,
                        DrawingPoint(
                          offset: details.localPosition,
                          paint: Paint()
                            ..color = currentColor
                            ..strokeWidth = currentLineWidth
                            ..strokeCap = StrokeCap.round
                            ..strokeJoin = StrokeJoin.round,
                        ),
                      ],
                    );
                  });
                },

                onPanEnd: (details) {
                  setState(() {
                    _current = _current.copyWith(
                      drawingPoints: [..._current.drawingPoints, null],
                    );
                  });
                },
                child: CustomPaint(
                  painter: DrawingPainter(
                    drawingPoints: _current.drawingPoints,
                    lineStyle: currentLineStyle,
                  ),
                ),
              ),
            ),

          // 배경 템플릿 패널
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            left: 0,
            right: 0,
            bottom: _showBackgroundPanel ? 100 : -350,
            child: BackgroundTabletPanel(
              onClose: () {
                setState(() {
                  _showBackgroundPanel = false;
                  _isDrawingMode = false;
                });
              },
              selectedColor: _current.background.color,
              onColorChanged: (color) {
                _applyState(_current.copyWith(
                  background: BackgroundState(color: color),
                ));
              },
            ),
          ),

          // 드로잉 툴 패널
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

          // 하단 고정 아이콘바
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
                onDrawPressed: () {
                  setState(() {
                    _showDrawingPanel = !_showDrawingPanel;
                    _isDrawingMode = _showDrawingPanel;
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
                    color: AppColors.gray300,
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: width,
                    height: height,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '표지 영역입니다.\n앨범의 표지를 꾸며주세요!',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.body16M140.copyWith(
                        color: AppColors.fontSecondary,
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


class BackgroundState {
  final Color? color;
  final ImageProvider? image;

  BackgroundState({this.color, this.image});
}

class EditorState {
  final List<DrawingPoint?> drawingPoints;
  final BackgroundState background;
  // final List<StickerItem> stickers;
  // final List<TextItem> texts;

  EditorState({
    this.drawingPoints = const [],
    BackgroundState? background,
  }) : background = background ?? BackgroundState();

  EditorState copyWith({
    List<DrawingPoint?>? drawingPoints,
    BackgroundState? background,
  }) {
    return EditorState(
      drawingPoints: drawingPoints ?? this.drawingPoints,
      background: background ?? this.background,
    );
  }
}

class DrawingPoint {
  final Offset offset;
  final Paint paint;

  DrawingPoint({required this.offset, required this.paint});
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;
  final String lineStyle;

  DrawingPainter({
    required this.drawingPoints,
    this.lineStyle = '실선',
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length - 1; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        final point1 = drawingPoints[i]!;
        final point2 = drawingPoints[i + 1]!;

        if (lineStyle == '점선') {
          _drawDashedLine(canvas, point1.offset, point2.offset, point1.paint);
        } else {
          canvas.drawLine(point1.offset, point2.offset, point1.paint);
        }
      }
    }
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;

    final distance = (p2 - p1).distance;
    if (distance == 0) return;

    final normalizedDirection = Offset(
      (p2.dx - p1.dx) / distance,
      (p2.dy - p1.dy) / distance,
    );

    double currentDistance = 0.0;
    while (currentDistance < distance) {
      final start = Offset(
        p1.dx + normalizedDirection.dx * currentDistance,
        p1.dy + normalizedDirection.dy * currentDistance,
      );
      currentDistance += dashWidth;

      final end = Offset(
        p1.dx + normalizedDirection.dx * currentDistance.clamp(0, distance),
        p1.dy + normalizedDirection.dy * currentDistance.clamp(0, distance),
      );

      canvas.drawLine(start, end, paint);
      currentDistance += dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
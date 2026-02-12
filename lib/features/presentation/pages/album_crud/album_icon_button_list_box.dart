import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/color_select_scale.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/photo_gallery_sheet.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/sticker_search_bottom_sheet.dart';

class EditorIconBar extends StatefulWidget {
  final VoidCallback? onDrawPressed;
  final VoidCallback? onBackgroundPressed;

  const EditorIconBar({
    super.key,
    this.onDrawPressed,
    this.onBackgroundPressed,
  });

  @override
  State<EditorIconBar> createState() => _EditorIconBarState();
}

class _EditorIconBarState extends State<EditorIconBar> {
  bool _isTextMode = false;
  Color? selectedColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _isTextMode ? _buildTextModeBar() : _buildMainBar(),
    );
  }

  Widget _buildMainBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(context, 'assets/system/icons/album_edit_1background.svg', () => widget.onBackgroundPressed?.call()),
        const SizedBox(width: 4),
        _buildIconButton(context, 'assets/system/icons/album_edit_2image_add.svg', () => _onImageAddPressed(context)),
        const SizedBox(width: 4),
        _buildIconButton(context, 'assets/system/icons/albun_edit_3text_push.svg', _onTextPushPressed),
        const SizedBox(width: 4),
        _buildIconButton(context, 'assets/system/icons/album_edit_4draw.svg', () => widget.onDrawPressed?.call()),
        const SizedBox(width: 4),
        _buildIconButton(context, 'assets/system/icons/albun_edit_5sticker.svg', () => _onStickerPressed(context)),
      ],
    );
  }

  Widget _buildTextModeBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconButton(context, 'assets/system/icons/text_edit_select_font.svg', _onFontPressed),
        const SizedBox(width: 4),
        _buildIconButton(context, 'assets/system/icons/text_edit_impact.svg', _onColorPressed),
        const SizedBox(width: 4),
        _buildIconButton(context, 'assets/system/icons/text_edit_middle.svg', _onAlignPressed),
        const SizedBox(width: 4),
        _buildIconButton(context, 'assets/system/icons/text_edit_italic.svg', _onItalicPressed),
        const SizedBox(width: 4),
        _buildIconButton(context, 'assets/system/icons/text_edit_underline.svg', _onUnderlinePressed),
        const SizedBox(width: 4),
        _buildColorButton(
          context,
          selectedColor ?? const Color(0xFFBDBDBD),
        ),
      ],
    );
  }

  Widget _buildIconButton(
      BuildContext context,
      String iconPath,
      VoidCallback? onPressed,
      ) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 24,
        minHeight: 24,
      ),
      visualDensity: VisualDensity.compact,
      icon: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
      ),
      onPressed: onPressed,
    );
  }

  // 메인 바 액션들
  Future<void> _onImageAddPressed(BuildContext context) async {
    final selectedPhotos = await PhotoGalleryBottomSheet.show(context);
    if (selectedPhotos != null && selectedPhotos.isNotEmpty) {
      print('Selected photos: $selectedPhotos');
    }
  }

  void _onTextPushPressed() {
    setState(() {
      _isTextMode = true; // 텍스트 모드로 전환
    });
  }

  Future<void> _onStickerPressed(BuildContext context) async {
    final selectedSticker = await StickerBottomSheet.show(context);
    if (selectedSticker != null) {
      print('선택된 스티커: ${selectedSticker.emoji} - ${selectedSticker.name}');
    }
  }

  // 텍스트 모드 액션들
  void _onFontPressed() {
    print('폰트 변경');
  }

  void _onAlignPressed() {
    print('정렬 변경');
  }

  void _onItalicPressed() {
    print('이탤릭 토글');
  }

  void _onUnderlinePressed() {
    print('밑줄 토글');
  }

  void _onColorPressed() async {
    final selectedColorResult = await showModalBottomSheet<Color>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true, // 드래그 가능
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.3, // 초기 높이 (화면의 30%)
        minChildSize: 0.2, // 최소 높이
        maxChildSize: 0.3, // 최대 높이
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            border: Border.all(
              color: const Color(0xFFF5F5F5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 드래그 인디케이터
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFBDBDBD),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: ColorSelectorSection(
                  selectedColor: selectedColor,
                  onChanged: (color) {
                    Navigator.pop(context, color);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (selectedColorResult != null) {
      setState(() {
        selectedColor = selectedColorResult;
      });
    }
  }

  Widget _buildColorButton(
      BuildContext context,
      Color color,
      ) {
    final isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        _onColorPressed();
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
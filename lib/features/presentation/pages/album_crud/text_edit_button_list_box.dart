import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/photo_gallery_sheet.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/sticker_search_bottom_sheet.dart';

class TextEditorIconBar extends StatelessWidget {
  final VoidCallback? onDrawPressed;
  final VoidCallback? onBackgroundPressed; // 추가

  const TextEditorIconBar({
    super.key,
    this.onDrawPressed,
    this.onBackgroundPressed, // 추가
  });

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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconButton(context, 'assets/system/icons/text_edit_font.svg', () => onBackgroundPressed?.call()),
          _buildIconButton(context, 'assets/system/icons/text_edit_middle.svg', () => _onImageAddPressed(context)),
          _buildIconButton(context, 'assets/system/icons/text_edit_italic.svg', () => onDrawPressed?.call()),
          _buildIconButton(context, 'assets/system/icons/text_edit_underline.svg', () => _onStickerPressed(context)),
          _buildIconButton(context, 'assets/system/icons/text_edit_,svg', () => _onTextPushPressed()),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      BuildContext context,
      String iconPath,
      VoidCallback onPressed,
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

  Future<void> _onImageAddPressed(BuildContext context) async {
    final selectedPhotos = await PhotoGalleryBottomSheet.show(context);
    if (selectedPhotos != null && selectedPhotos.isNotEmpty) {
      print('Selected photos: $selectedPhotos');
    }
  }

  void _onTextPushPressed() {
    // 텍스트 추가 로직
  }

  void _onStickerPressed(BuildContext context) async {
    final selectedSticker = await StickerBottomSheet.show(context);

    if (selectedSticker != null) {
      print('선택된 스티커: ${selectedSticker.emoji} - ${selectedSticker.name}');
      // 여기서 선택된 스티커를 처리하는 로직 추가
    }
  }
}
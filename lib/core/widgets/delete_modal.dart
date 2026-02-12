import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_button_theme.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String cancelText;
  final String confirmText;

  const DeleteConfirmDialog({
    Key? key,
    this.title = '삭제하시겠습니까?',
    required this.content,
    required this.onConfirm,
    this.cancelText = '취소',
    this.confirmText = '삭제',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: AppTextStyle.subtitle20Sb120.copyWith(
          color: AppColors.f01,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        style: AppTextStyle.body16R120.copyWith(
          color: AppColors.f01,
        ),
        textAlign: TextAlign.center,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: AppButtonTheme.gray.style,
                child: Text(
                  cancelText,
                  style: AppTextStyle.body16M120,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                style: AppButtonTheme.elevated.style,
                child: Text(
                  confirmText,
                  style: AppTextStyle.body16M120.copyWith(
                    color: AppColors.f01,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Future<void> show({
    required BuildContext context,
    String? title,
    required String content,
    required VoidCallback onConfirm,
    String? cancelText,
    String? confirmText,
  }) {
    return showDialog(
      context: context,
      builder: (context) => DeleteConfirmDialog(
        title: title ?? '삭제하시겠습니까?',
        content: content,
        onConfirm: onConfirm,
        cancelText: cancelText ?? '취소',
        confirmText: confirmText ?? '삭제',
      ),
    );
  }
}
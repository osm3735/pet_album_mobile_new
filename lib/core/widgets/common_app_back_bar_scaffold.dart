import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
class CommonBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const CommonBackAppBar({
    super.key,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Text(
          '<',
          style: AppTextStyle.subtitle20M120.copyWith(
            color: AppColors.f05,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ), // 24 X 24
      title: title == null
          ? null
          : Text(
        title!,
        style: AppTextStyle.subtitle20M120.copyWith(
          color: AppColors.f05,
        ),
      ),
      centerTitle: false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
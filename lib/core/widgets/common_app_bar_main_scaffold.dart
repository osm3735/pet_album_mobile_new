import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leadingContent;
  final EdgeInsetsGeometry? leadingPadding;

  const CommonMainAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leadingContent,
    this.leadingPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      leadingWidth: 120,
      leading: leadingContent == null
          ? null
          : Padding(
        padding: leadingPadding ?? EdgeInsets.zero,
        child: leadingContent,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

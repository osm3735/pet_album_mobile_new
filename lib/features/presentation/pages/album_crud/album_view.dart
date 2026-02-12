import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/widgets/common_app_bar_main_scaffold.dart';
import 'package:petAblumMobile/features/presentation/pages/album/album_page.dart';

class AlbumViewPage extends StatefulWidget {
  const AlbumViewPage({super.key});

  @override
  State<AlbumViewPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonMainAppBar(
        title: '',
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => const AlbumPage(),
            ),
            );
          },
          ),
          IconButton(icon: const Icon(Icons.apps), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/system/dumy/dumy01.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: () => print("편집 클릭"),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF4A4A4A).withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)
                    ],
                  ),
                  child: const Icon(Icons.edit, size: 28, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
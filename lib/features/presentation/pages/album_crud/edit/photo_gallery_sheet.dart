import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';

/// 갤러리 사진 선택 바텀시트
class PhotoGalleryBottomSheet extends StatefulWidget {
  const PhotoGalleryBottomSheet({Key? key}) : super(key: key);

  @override
  State<PhotoGalleryBottomSheet> createState() => _PhotoGalleryBottomSheetState();

  /// 바텀시트를 표시하는 헬퍼 메서드
  static Future<List<int>?> show(BuildContext context) {
    return showModalBottomSheet<List<int>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => const PhotoGalleryBottomSheet(),
    );
  }
}

class _PhotoGalleryBottomSheetState extends State<PhotoGalleryBottomSheet> {
  final Set<int> selectedPhotos = {};
  String selectedFilter = '최근항목';
  final DraggableScrollableController _controller = DraggableScrollableController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 데모용 사진 데이터
  final List<PhotoItem> photos = List.generate(
    20,
        (index) {
      if (index == 0) return PhotoItem(type: PhotoType.camera);
      return PhotoItem(
        type: PhotoType.image,
        imageUrl: 'https://images.unsplash.com/photo-${1543466835000 + index}',
        hasVideo: index % 3 == 0,
      );
    },
  );

  void toggleSelection(int index) {
    if (index == 0) return;
    setState(() {
      if (selectedPhotos.contains(index)) {
        selectedPhotos.remove(index);
      } else {
        selectedPhotos.add(index);
      }
    });
  }

  void onUpload() {
    if (selectedPhotos.isEmpty) return;
    Navigator.pop(context, selectedPhotos.toList());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final initialSize = 359 / screenHeight;

    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: initialSize,
      minChildSize: initialSize,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  final delta = details.primaryDelta! / screenHeight;
                  final newSize = (_controller.size - delta).clamp(initialSize, 0.95);
                  _controller.jumpTo(newSize);
                },
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // 드래그 핸들
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 8),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // 헤더 (필터 + 업로드 버튼)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 최근항목 드롭다운
                            PopupMenuButton<String>(
                              offset: const Offset(0, 40),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    selectedFilter,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey[700],
                                    size: 20,
                                  ),
                                ],
                              ),
                              itemBuilder: (BuildContext context) => [
                                _buildPopupMenuItem('최근항목'),
                                _buildPopupMenuItem('다운로드'),
                                _buildPopupMenuItem('즐겨찾기'),
                                _buildPopupMenuItem('폴더이름'),
                              ],
                              onSelected: (String value) {
                                setState(() {
                                  selectedFilter = value;
                                });
                              },
                            ),

                            // 업로드 버튼
                            ElevatedButton(
                              onPressed: selectedPhotos.isNotEmpty ? onUpload : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B3B3B),
                                disabledBackgroundColor: Colors.grey[300],
                                foregroundColor: Colors.white,
                                disabledForegroundColor: Colors.grey[500],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 10,
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                '업로드',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),

              // ===== 갤러리 그리드 영역 =====
              Expanded(
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(2),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio: 1,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final photo = photos[index];
                            final isSelected = selectedPhotos.contains(index);

                            return GestureDetector(
                              onTap: () => toggleSelection(index),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (photo.type == PhotoType.camera)
                                    Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 48,
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  else
                                    Image.network(
                                      photo.imageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: Icon(
                                            Icons.image,
                                            size: 48,
                                            color: Colors.grey[600],
                                          ),
                                        );
                                      },
                                    ),

                                  if (isSelected)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),

                                  if (photo.type == PhotoType.image)
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected
                                              ? const Color(0xFFFBBC05)
                                              : Colors.white.withOpacity(0.8),
                                          border: Border.all(
                                            color: isSelected
                                                ? const Color(0xFFFBBC05)
                                                : Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? const Center(
                                          child: Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        )
                                            : null,
                                      ),
                                    ),

                                  if (photo.hasVideo)
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                        child: const Icon(
                                          Icons.play_arrow,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                                  if (photo.hasSpecialIcon)
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.yellow[700],
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                          childCount: photos.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title) {
    final isSelected = selectedFilter == title;
    return PopupMenuItem<String>(
      value: title,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.body16M120.copyWith(
              color: isSelected ? AppColors.fontStrong : AppColors.fontHint,
            ),
          ),
        ],
      ),
    );
  }
}

enum PhotoType {
  camera,
  image,
}

class PhotoItem {
  final PhotoType type;
  final String? imageUrl;
  final bool hasVideo;
  final bool hasSpecialIcon;

  PhotoItem({
    required this.type,
    this.imageUrl,
    this.hasVideo = false,
    this.hasSpecialIcon = false,
  });
}
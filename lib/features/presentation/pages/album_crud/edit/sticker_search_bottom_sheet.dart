import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/widgets/app_text_field.dart';

// 스티커 모델
class Sticker {
  final String id;
  final String emoji;
  final String name;

  const Sticker({
    required this.id,
    required this.emoji,
    required this.name,
  });
}

class StickerBottomSheet extends StatefulWidget {
  const StickerBottomSheet({Key? key}) : super(key: key);

  @override
  State<StickerBottomSheet> createState() => _StickerBottomSheetState();

  static Future<Sticker?> show(BuildContext context) {
    return showModalBottomSheet<Sticker>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => const StickerBottomSheet(),
    );
  }
}

class _StickerBottomSheetState extends State<StickerBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = ['전체', '문자', '장난감', '데코', '음식', '자연'];

  final Map<String, List<Sticker>> _stickersByCategory = {
    '전체': [
      Sticker(id: '1', emoji: '😀', name: '웃음'),
      Sticker(id: '2', emoji: '😂', name: '기쁨'),
      Sticker(id: '3', emoji: '😍', name: '사랑'),
      Sticker(id: '4', emoji: '🥰', name: '행복'),
      Sticker(id: '5', emoji: '😎', name: '멋짐'),
      Sticker(id: '6', emoji: '🤔', name: '생각'),
      Sticker(id: '7', emoji: '😭', name: '슬픔'),
      Sticker(id: '8', emoji: '😱', name: '놀람'),
      Sticker(id: '9', emoji: '🐶', name: '강아지'),
      Sticker(id: '10', emoji: '🐱', name: '고양이'),
      Sticker(id: '11', emoji: '🍕', name: '피자'),
      Sticker(id: '12', emoji: '🍔', name: '햄버거'),
    ],
    '문자': [
      Sticker(id: '13', emoji: '👨‍🏫', name: '선생님'),
      Sticker(id: '14', emoji: '📚', name: '책'),
      Sticker(id: '15', emoji: '✏️', name: '연필'),
    ],
    '장난감': [
      Sticker(id: '16', emoji: '🚚', name: '트럭'),
      Sticker(id: '17', emoji: '📦', name: '상자'),
      Sticker(id: '18', emoji: '🏃', name: '달리기'),
    ],
    '데코': [
      Sticker(id: '19', emoji: '🎯', name: '목표'),
      Sticker(id: '20', emoji: '💪', name: '힘'),
      Sticker(id: '21', emoji: '🏆', name: '우승'),
    ],
    '음식': [
      Sticker(id: '22', emoji: '⭐', name: '별'),
      Sticker(id: '23', emoji: '🌙', name: '달'),
      Sticker(id: '24', emoji: '☀️', name: '태양'),
    ],
    '자연': [
      Sticker(id: '25', emoji: '🎨', name: '미술'),
      Sticker(id: '26', emoji: '🎵', name: '음악'),
      Sticker(id: '27', emoji: '💃', name: '춤'),
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onStickerTap(Sticker sticker) {
    Navigator.pop(context, sticker);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final initialHeight = 256.0;
    final maxHeight = screenHeight * 0.9;

    return DraggableScrollableSheet(
      initialChildSize: initialHeight / screenHeight,
      minChildSize: initialHeight / screenHeight,
      maxChildSize: maxHeight / screenHeight,
      expand: true,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // 드래그 핸들 - SingleChildScrollView로 감싸서 드래그 가능하게
              SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    // 드래그 핸들
                    Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.f01,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // 검색바 (AppTextField 사용)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: AppTextField(
                        controller: _searchController,
                        hintText: '검색어를 입력해주세요.',
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                          color: AppColors.f01,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                            : null,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: AppColors.f01,
                        unselectedLabelColor: AppColors.f01,
                        indicator: BoxDecoration(
                          color: AppColors.f01,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding: const EdgeInsets.symmetric(horizontal: -8, vertical: 4),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        padding: EdgeInsets.zero,
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        dividerHeight: 0,
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        tabs: _categories.map((category) => Tab(text: category)).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              // 스티커 그리드
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _categories.map((category) {
                    final stickers = _stickersByCategory[category] ?? [];

                    if (stickers.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.image_not_supported_outlined,
                              size: 64,
                              color: AppColors.f01,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '스티커가 없습니다',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.f01,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),
                      itemCount: stickers.length,
                      itemBuilder: (context, index) {
                        final sticker = stickers[index];
                        return GestureDetector(
                          onTap: () => _onStickerTap(sticker),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.f01,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.f01,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                sticker.emoji,
                                style: const TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

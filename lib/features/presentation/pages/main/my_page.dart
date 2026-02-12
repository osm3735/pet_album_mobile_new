import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_common_button_styles.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/theme/app_text_semantic.dart';
import 'package:petAblumMobile/core/widgets/app_text_field.dart';
import 'package:petAblumMobile/core/widgets/common_app_bar_main_scaffold.dart';
import 'package:petAblumMobile/core/widgets/pet_card.dart';
import 'package:petAblumMobile/features/presentation/pages/main/settings_page.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_list.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final TextEditingController _foodController = TextEditingController();

  @override
  void dispose() {
    _foodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.f01,
      appBar: CommonMainAppBar(
        title: "마이페이지",
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // 반려동물 프로필 사진
              Column(
                children: [
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/system/logo/logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.pets,
                              size: 60,
                              color: AppColors.f01,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '조혜원',
                    style: AppText.titleStrong,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '또또네 가족',
                    style: AppTextStyle.body16R120.copyWith(
                      color: AppColors.f01,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 140,
                    height: 40,
                    child:
                    ElevatedButton(
                      style: AppButtonStyles.base(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.f01,
                      ).copyWith(
                        elevation: MaterialStateProperty.all(2), // 살짝 떠 있는 느낌
                        shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.08)),

                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24), // pill 형태
                          ),
                        ),

                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),

                        side: MaterialStateProperty.all(BorderSide.none), // 테두리 제거
                      ),
                      onPressed: () {
                        // 정보 수정 페이지 이동
                      },
                      child: Text(
                        '내 정보 수정',
                        style: AppTextStyle.body16R120.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // 반려동물 정보 카드
              _buildPetCard(0),
              // ListView(
              //   padding: const EdgeInsets.all(20),
              //   children: [
              //     _buildPetCard(0),
              //     const SizedBox(height: 16),
              //     _buildPetCard(1),
              //     const SizedBox(height: 24),
              //   ],
              // ),

              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child:Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '반려동물 정보',
                          style: AppText.titleStrong,
                        ),
                        const SizedBox(height: 20),

                        // 성향
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                '성향',
                                style: AppText.bodyPrimary.copyWith(
                                  color: AppColors.f01,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildChip('쿤스리 주인'),
                                  _buildChip('이웃집 쉽게 주위 필요'),
                                  _buildChip('인적경영있음'),
                                  _buildChip('분리불안'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 건강
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                '건강',
                                style: AppText.bodyPrimary.copyWith(
                                  color: AppColors.f01,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildChip('관절문제있음'),
                                  _buildChip('슬개골문제 있음'),
                                  _buildChip('피부문제있음'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 특등의
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                '특등의',
                                style: AppText.bodyPrimary.copyWith(
                                  color: AppColors.f01,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '없음',
                                style: AppText.bodyPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 페이지 인디케이터
                        _buildPageIndicator(),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // 반려동물
              Text(
                '반려동물',
                style: AppText.titleStrong,
              ),
              const SizedBox(height: 8),
              Text(
                '내 엘범',
                style: AppText.bodyPrimary,
              ),

              const SizedBox(height: 20),

              Text(
                '패밀리',
                style: AppText.titleStrong,
              ),
              const SizedBox(height: 8),
              Text(
                '패밀리 계정 만들기',
                style: AppText.bodyPrimary,
              ),
              const SizedBox(height: 8),
              Text(
                '패밀리 관리하기',
                style: AppText.bodyPrimary,
              ),

              const SizedBox(height: 20),

              // 펫시터
              Text(
                '펫시터',
                style: AppText.titleStrong,
              ),
              const SizedBox(height: 8),
              Text(
                '펫시터 이용 내역',
                style: AppText.bodyPrimary,
              ),
              const SizedBox(height: 8),
              Text(
                '내 후기 관리',
                style: AppText.bodyPrimary,
              ),

              const SizedBox(height: 20),

              // 결제
              Text(
                '결제',
                style: AppText.titleStrong,
              ),
              const SizedBox(height: 8),
              Text(
                '결제수단 등록',
                style: AppText.bodyPrimary,
              ),
              const SizedBox(height: 8),
              Text(
                '결제수단 변경',
                style: AppText.bodyPrimary,
              ),

              const SizedBox(height: 20),

              // 라이프케어
              Text(
                '라이프케어',
                style: AppText.titleStrong,
              ),
              const SizedBox(height: 8),
              Text(
                '라이프케어란?',
                style: AppText.bodyPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.f01,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: AppText.bodyPrimary.copyWith(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.f01,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.f01,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildPetCard(int index) {
    return PetCard(
      imageUrl: 'assets/system/logo/logo.png',
      name: '또또 (2세)',
      species: '말티즈',
      personality: ['코지', '예민함', '물어요', '손조심'],
      favoriteToy: '목욕',
      sex: '수컷',
      birth: '2025.01.02',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PetListPage()),
        );
      },
    );
  }

}
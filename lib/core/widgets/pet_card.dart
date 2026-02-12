import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_dahyun.dart';

class PetCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String species;
  final List<String>? personality;
  final String favoriteToy;
  final String sex;
  final String birth;
  final VoidCallback? onTap;
  final Widget? topRightIcon;

  const PetCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.species,
    required this.personality,
    required this.favoriteToy,
    required this.sex,
    required this.birth,
    this.onTap,
    this.topRightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Center(
          child: SizedBox( // Container 대신 가벼운 SizedBox 사용
          width: 350,
          height: 210,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // SVG 배경
              SvgPicture.asset(
                'assets/system/pet_card/dog_pet_card.svg',
                width: 350,
                height: 210,
                fit: BoxFit.contain,
              ),

              if (topRightIcon != null)
                Positioned(
                  right: 30,
                  top: -15,
                  child: topRightIcon!,
                ),

              Positioned(
                left: 205,  // 상단 박스 중앙으로 이동
                top: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    width: 108, // 요청하신 작은 크기로 변경
                    height: 102,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 108, // 요청하신 작은 크기로 변경
                      height: 102,
                      color: Colors.grey[200],
                      child: const Icon(Icons.pets, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              _buildTextOverlays(),
              Positioned(
                right: 33,
                bottom: 55,
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    'assets/system/pet_card/idcard_part.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildTextOverlays() {
    return Stack(
      children: [
        Positioned(
          left: 80,
          top: 50,
          width: 160,
          child: Stack(
            children: [
              // stroke (외곽선)
              Text(
                name,
                style: AppTextStyleDahyun.dahyun(
                  size: 20,
                  weight: FontWeight.w400,
                  height: 1.0,
                ).copyWith(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = const Color(0xFF111111),
                  letterSpacing: -0.3,
                ),
              ),

              // fill (채우기)
              Text(
                name,
                style: AppTextStyleDahyun.dahyun(
                  size: 20,
                  weight: FontWeight.w400,
                  height: 1.0,
                ).copyWith(
                  color: const Color(0xFFFFEAA2),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 35,
          top: 95,
          child: Text(
            '나이 : $favoriteToy    품종 : $species',
            style: AppTextStyleDahyun.dahyun(
              size: 14,
              weight: FontWeight.normal,
              height: 1.2,
            ),
          ),
        ),
        Positioned(
          left: 35,
          top: 118,
          child: Text(
            '성별 : $sex    생일 : $birth',
            style: AppTextStyleDahyun.dahyun(
              size: 14,
              weight: FontWeight.normal,
              height: 1.2,
            ),
          ),
        ),
        Positioned(
          left: 35,
          top: 140,
          right: 210,
          child: _buildPersonalityText(personality),
        ),
        Positioned(
          left: 220,
          top: 152,
          child: Text(
            '성격 : ${personality?.join(' ') ?? ''}',
            style: AppTextStyleDahyun.dahyun(
              size: 14,
              weight: FontWeight.normal,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalityText(List<String>? personality) {
    if (personality == null || personality.isEmpty) {
      return const SizedBox.shrink();
    }

    if (personality.length <= 2) {
      return Text(
        '성격 : ${personality.map((p) => '#$p').join(' ')}',
        style: AppTextStyleDahyun.dahyun(
          size: 14,
          weight: FontWeight.normal,
          height: 1.2,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '성격 : ${personality.take(2).map((p) => '#$p').join(' ')}',
          style: AppTextStyleDahyun.dahyun(
            size: 14,
            weight: FontWeight.normal,
            height: 1.2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            personality.skip(2).map((p) => '#$p').join(' '),
            style: AppTextStyleDahyun.dahyun(
              size: 14,
              weight: FontWeight.normal,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

}
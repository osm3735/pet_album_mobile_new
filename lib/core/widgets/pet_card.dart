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
  final String petFamily;

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
    required this.petFamily,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double w = constraints.maxWidth;
        final double h = w * (210 / 350);
        final double s = w / 350;

        return GestureDetector(
          onTap: onTap,
          child: Center(
            child: SizedBox(
              width: w,
              height: h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // SVG 배경
                  SvgPicture.asset(
                    'assets/system/pet_card/dog_pet_card.svg',
                    width: w,
                    height: h,
                    fit: BoxFit.contain,
                  ),

                  if (topRightIcon != null)
                    Positioned(
                      right: 30 * s,
                      top: -15 * s,
                      child: topRightIcon!,
                    ),

                  Positioned(
                    left: 205 * s,
                    top: 36 * s,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12 * s),
                      child: Image.network(
                        imageUrl,
                        width: 108 * s,
                        height: 102 * s,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 108 * s,
                          height: 102 * s,
                          color: Colors.grey[200],
                          child: const Icon(Icons.pets, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),

                  _buildTextOverlays(s),

                  Positioned(
                    right: 33 * s,
                    bottom: 55 * s,
                    child: SizedBox(
                      width: 30 * s,
                      height: 30 * s,
                      child: SvgPicture.asset(
                        'assets/system/pet_card/idcard_part.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextOverlays(double s) {
    return Stack(
      children: [
        Positioned(
          left: 80 * s,
          top: 50 * s,
          width: 160 * s,
          child: Stack(
            children: [
              Text(
                name,
                style: AppTextStyleDahyun.dahyun(
                  size: 20 * s,
                  weight: FontWeight.w400,
                  height: 1.0 * s,
                ).copyWith(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1 * s
                    ..color = const Color(0xFF111111),
                  letterSpacing: -0.3 * s,
                ),
              ),
              Text(
                name,
                style: AppTextStyleDahyun.dahyun(
                  size: 20 * s,
                  weight: FontWeight.w400,
                  height: 1.0  * s,
                ).copyWith(
                  color: const Color(0xFFFFEAA2),
                  letterSpacing: -0.3 * s,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 35 * s,
          top: 95 * s,
          child: Text(
            '나이 : $favoriteToy  품종 : $species',
            style: AppTextStyleDahyun.dahyun(
              size: 14 * s,
              weight: FontWeight.normal,
              height: 1.2 * s,
            ),
          ),
        ),
        Positioned(
          left: 35 * s,
          top: 118 * s,
          child: Text(
            '성별 : $sex   생일 : $birth',
            style: AppTextStyleDahyun.dahyun(
              size: 14 * s,
              weight: FontWeight.normal,
              height: 1.2 * s,
            ),
          ),
        ),
        Positioned(
          left: 35 * s,
          top: 140 * s,
          width: 160 * s,
          child: _buildPersonalityText(personality, s),
        ),
        Positioned(
          left: 220 * s,
          top: 152 * s,
          child: Text(
            petFamily,
            style: AppTextStyleDahyun.dahyun(
              size: 14 * s,
              weight: FontWeight.normal,
              height: 1.2 * s,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalityText(List<String>? personality, double s) {
    if (personality == null || personality.isEmpty) {
      return const SizedBox.shrink();
    }

    final textStyle = AppTextStyleDahyun.dahyun(
      size: 14 * s,
      weight: FontWeight.normal,
      height: 1.2,
    );

    if (personality.length <= 2) {
      return Text(
        '성격 : ${personality.map((p) => '#$p').join(' ')}',
        style: textStyle,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '성격 : ${personality.take(2).map((p) => '#$p').join(' ')}',
          style: textStyle,
        ),
        Padding(
          padding: EdgeInsets.only(left: 30 * s),
          child: Text(
            personality.skip(2).map((p) => '#$p').join(' '),
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
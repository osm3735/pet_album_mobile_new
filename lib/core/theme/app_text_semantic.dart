import 'app_fonts_style_suit.dart';
import 'app_colors.dart';

class AppText {
  /// 보조 설명, 캡션
  static final captionSecondary =
  AppTextStyle.caption12R120.copyWith(
    color: AppColors.f02,
  );

  /// 기본 본문
  static final bodyPrimary =
  AppTextStyle.body16R120.copyWith(
    color: AppColors.f01,
  );

  /// 힌트 / 플레이스홀더
  static final bodyHint =
  AppTextStyle.body16R120.copyWith(
    color: AppColors.f01,
  );

  /// 타이틀 / 강조
  static final titleStrong =
  AppTextStyle.subtitle20Sb120.copyWith(
    color: AppColors.f01,
  );

  /// 버튼 텍스트
  static final buttonPrimary =
  AppTextStyle.body16M120.copyWith(
    color: AppColors.f01, // #FFFFFF
  );
}

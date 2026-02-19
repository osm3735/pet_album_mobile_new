import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_common_button_styles.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/theme/app_text_semantic.dart';
import 'package:petAblumMobile/features/presentation/pages/auth/login_form.dart';
import 'package:petAblumMobile/features/presentation/pages/auth/sign_up_page.dart';

class Oauth2LoginPage extends StatelessWidget {
  const Oauth2LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 로고
              Image.asset(
                'assets/system/logo/logo.png',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 48),

              // 카카오 로그인
              SizedBox(
                width: 350,
                height: 55,
                child: ElevatedButton(
                  style: AppButtonStyles.base(
                    backgroundColor: const Color(0xFFFFE812),
                    foregroundColor: AppColors.f05,
                  ),
                  onPressed: () {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          'assets/system/icons/kakao_logo.svg',
                          width: 32,
                          height: 32,
                        ),
                      ),
                      const Text('카카오 로그인 하기'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // 구글 로그인
              SizedBox(
                width: 350,
                height: 55,
                child: OutlinedButton(
                  style: AppButtonStyles.base(
                    backgroundColor: AppColors.gray01,
                    foregroundColor: Colors.black,
                  ).copyWith(
                    side: WidgetStateProperty.all(
                      const BorderSide(color: AppColors.gray01),
                    ),
                  ),
                  onPressed: () {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          'assets/system/icons/google_logo.svg',
                          width: 32,
                          height: 32,
                        ),
                      ),
                      const Text('구글 로그인 하기'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 구분선
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:37),
                    child: Text(
                      '또는',
                      style: AppText.captionSecondary,
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),//width 60

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset('assets/system/icons/apple.svg', width: 52, height: 52),
                  ),
                  const SizedBox(width: 8), // 원하는 간격 명시적으로 지정
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset('assets/system/icons/naver.svg', width: 52, height: 52),
                  ),
                ],
              ),//추후

              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      '회원가입',
                      style: AppTextStyle.caption12R120.copyWith(
                        color: AppColors.f04,
                      ),
                    ),
                  ),
                  const Text('|'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const IdLoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      '아이디 로그인',
                      style: AppTextStyle.caption12R120.copyWith(
                        color: AppColors.f04,
                      ),
                    ),
                  ),
                  const Text('|'),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '문의하기',
                      style: AppTextStyle.caption12R120.copyWith(
                        color: AppColors.f04,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

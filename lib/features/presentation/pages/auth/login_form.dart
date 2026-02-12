import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_button_theme.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/theme/app_text_semantic.dart';
import 'package:petAblumMobile/core/widgets/app_text_field.dart';
import 'package:petAblumMobile/core/widgets/common_app_back_bar_scaffold.dart';
import 'package:petAblumMobile/features/presentation/pages/main/home_page.dart';
import 'package:petAblumMobile/features/presentation/pages/main/main_shell.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_health_form.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_type_create.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_info_form.dart';

class IdLoginPage extends StatefulWidget {
  const IdLoginPage({super.key});

  @override
  State<IdLoginPage> createState() => _IdLoginPageState();
}

class _IdLoginPageState extends State<IdLoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _submit() {
    final id = _idController.text.trim();
    final password = _passwordController.text;

    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디와 비밀번호를 입력해주세요')),
      );
      return;
    }
    debugPrint('ID: $id');
    debugPrint('PASSWORD: $password');
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonBackAppBar(title: '로그인'),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '아이디',
                  style: AppTextStyle.body16M120.copyWith(
                    color: AppColors.f03
                  ),
              ),
              const SizedBox(height: 8),
              AppTextField(
                controller: _idController,
                hintText: '아이디를 작성해 주세요.',
              ),
              const SizedBox(height: 20),
              Text(
                '비밀번호',
                style: AppTextStyle.body16M120.copyWith(
                    color: AppColors.f03
                ),
              ),
              const SizedBox(height: 8),
              AppTextField(
                controller: _passwordController,
                hintText: '비밀번호를 입력해 주세요.',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainShell()),
                        (route) => false,
                  );
                },
                style: AppButtonTheme.elevated.style,
                child: const Text('로그인'),
              ),
              _snsLoginSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _snsLoginSection() {
    return Column(
      children: [
        const SizedBox(height: 32),
        Row(
          children: [
            const Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'SNS 로그인',
                style: AppText.captionSecondary,
              ),
            ),
            const Expanded(child: Divider(thickness: 1)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _snsButton(asset: 'assets/system/icons/kakao.png', onTap: () => debugPrint('카카오 로그인')),
            const SizedBox(width: 10),
            _snsButton(asset: 'assets/system/icons/google.png', onTap: () => debugPrint('구글 로그인')),
            const SizedBox(width: 10),
            _snsButton(asset: 'assets/system/icons/apple.png', onTap: () => debugPrint('애플 로그인')),
            const SizedBox(width: 10),
            _snsButton(asset: 'assets/system/icons/naver.png', onTap: () => debugPrint('네이버 로그인')),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _snsButton({required String asset, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        asset,
        width: 52,
        height: 52,
      ),
    );
  }
}

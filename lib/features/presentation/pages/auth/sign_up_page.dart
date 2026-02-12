import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_button_theme.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_text_semantic.dart';
import 'package:petAblumMobile/core/widgets/app_text_field.dart';
import 'package:petAblumMobile/features/presentation/pages/auth/login_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;

  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool get _isFormFilled =>
      _idController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _idController.addListener(_updateState);
    _passwordController.addListener(_updateState);
    _nameController.addListener(_updateState);
    _emailController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _isFormFilled;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('회원가입', style: AppText.titleStrong),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Text('<',
              style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text('아이디', style: AppText.captionSecondary),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _idController,
                            hintText: '아이디를 입력하세요.',
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 101,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: AppButtonTheme.elevated.style,
                            child: const Text('중복확인'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('사용가능한 아이디입니다.', style: AppText.captionSecondary),
                    // Text('사용가능한 아이디입니다.', style: AppText.captionSecondary),
                    const SizedBox(height: 6),
                    Text('비밀번호', style: AppText.captionSecondary),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _passwordController,
                      hintText: '비밀번호를 입력해 주세요.',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.f03,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 20),
                    Text('이름', style: AppText.captionSecondary),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _nameController,
                      hintText: '이름을 작성해 주세요.',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 20),
                    Text('이메일', style: AppText.captionSecondary),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _emailController,
                      hintText: '이메일을 입력해주세요.',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: isActive
                      ? AppButtonTheme.elevated.style
                      : AppButtonTheme.inactive_btn.style,
                  onPressed: isActive
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const IdLoginPage(),
                      ),
                    );
                  }
                      : null,
                  child: const Text('회원가입'),
                ),
              ),// 보류
            ),
          ],
        ),
      ),
    );
  }
}

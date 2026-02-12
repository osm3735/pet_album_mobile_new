import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/widgets/common_app_back_bar_scaffold.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonBackAppBar(
        title: '설정',
      ),
      backgroundColor: AppColors.f01,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('계정'),
          _card([
            _item('개인정보 변경'),
            _item('비밀번호 변경'),
            _item('펫시터 계정으로 전환'),
          ]),
          const SizedBox(height: 16),

          _sectionTitle('알림'),
          _card([
            _item('메시지 알림'),
            _item('펫시터 알림'),
          ]),
          const SizedBox(height: 16),

          _sectionTitle('보안'),
          _card([
            _item('로그인 기기 관리'),
          ]),
          const SizedBox(height: 16),

          _sectionTitle('도움'),
          _card([
            _item('자주 묻는 질문'),
            _item('고객센터'),
          ]),
          const SizedBox(height: 16),

          _sectionTitle('약관 및 정책'),
          _card([
            _item('서비스 이용 약관'),
            _item('개인정보 처리 방침'),
          ]),
          const SizedBox(height: 16),

          _card([
            _item('로그아웃', showArrow: false),
            _item(
              '회원탈퇴',
              showArrow: false,
              color: Colors.red,
            ),
          ]),
        ],
      ),
    );
  }
}

Widget _sectionTitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.f01,
      ),
    ),
  );
}

Widget _card(List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(children: children),
  );
}
Widget _item(
    String text, {
      bool showDivider = false,
      bool showArrow = true,
      Color? color,
    }) {
  return Column(
    children: [
      ListTile(
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: color ?? AppColors.f01,
          ),
        ),
        trailing: showArrow
            ? const Icon(Icons.chevron_right, color: AppColors.f01)
            : null,
      ),
      if (showDivider)
        const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
    ],
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
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
      backgroundColor: AppColors.bg,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _card([
            _sectionTitle('계정'),
            _item('개인정보 변경'),
            _item('비밀번호 변경'),
            _item('펫시터 계정으로 전환'),
          ]),
          const SizedBox(height: 16),


          _card([
            _sectionTitle('알림'),
            _item('메시지 알림'),
            _item('펫시터 알림'),
          ]),
          const SizedBox(height: 16),


          _card([
            _sectionTitle('보안'),
            _item('로그인 기기 관리'),
          ]),
          const SizedBox(height: 16),


          _card([
            _sectionTitle('도움'),
            _item('자주 묻는 질문'),
            _item('고객센터'),
          ]),
          const SizedBox(height: 16),


          _card([
            _sectionTitle('약관 및 정책'),
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
    padding: const EdgeInsets.only( left: 16, bottom: 8, top: 16),
    child: Text(
      text,
      style: AppTextStyle.subtitle20M120.copyWith(
        color: AppColors.f05
      )


    ),
  );
}

Widget _card(List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: children,),
  );
}
Widget _item(
    String text, {
      bool showDivider = false,
      bool showArrow = true,
      Color? color,
    }) {
  return SizedBox(
    width: 318,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: AppTextStyle.body16R120.copyWith(
                  color: color ?? AppColors.f04,
                ),
              ),
              if (showArrow)
                SvgPicture.asset(
                  'assets/system/icons/chevron_right.svg',
                  width: 24,
                  height: 24,
                ),
            ],
          ),
        ),
      ],
    ),
  );
}


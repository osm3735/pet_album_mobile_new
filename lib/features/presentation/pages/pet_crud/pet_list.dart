import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/widgets/common_app_back_bar_scaffold.dart';
import 'package:petAblumMobile/core/widgets/common_navigation_scaffold.dart';
import 'package:petAblumMobile/core/widgets/delete_modal.dart';
import 'package:petAblumMobile/core/widgets/pet_card.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_type_create.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({super.key});

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  bool _isDeleteMode = false;
  final Set<int> _selectedPets = {};

  void _toggleDeleteMode() {
    setState(() {
      _isDeleteMode = !_isDeleteMode;
      if (!_isDeleteMode) {
        _selectedPets.clear();
      }
    });
  }

  void _togglePetSelection(int index) {
    setState(() {
      if (_selectedPets.contains(index)) {
        _selectedPets.remove(index);
      } else {
        _selectedPets.add(index);
      }
    });
  }

  void _deleteSelectedPets() {
    DeleteConfirmDialog.show(
      context: context,
      content: '${_selectedPets.length}개의 반려동물을 삭제하시겠습니까?',
      onConfirm: () {
        // 백엔드API
        setState(() {
          _selectedPets.clear();
          _isDeleteMode = false;
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonBackAppBar(
        title: '반려동물 캐릭터 관리',
        actions: _isDeleteMode
            ? [
          TextButton(
            onPressed: _selectedPets.isEmpty ? null : _deleteSelectedPets,
            child: Text(
              '삭제',
              style: TextStyle(
                color: _selectedPets.isEmpty ? Colors.grey : Colors.red,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: _toggleDeleteMode,
            child: const Text(
              '취소',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ]
            : [
          IconButton(
            onPressed: _toggleDeleteMode,
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.f01,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildPetCard(0),
          const SizedBox(height: 12),
          _buildPetCard(1),
          const SizedBox(height: 24),
          if (!_isDeleteMode) _AddPetButton(),
        ],
      ),
    );
  }

  Widget _buildPetCard(int index) {
    final isSelected = _selectedPets.contains(index);

    return PetCard(
      imageUrl: 'assets/system/logo/logo.png',
      name: '또또 (2세)',
      species: '말티즈',
      personality: ['코지', '예민함', '물어요', '손조심'],
      favoriteToy: '목욕',
      sex: '수컷',
      birth: '2025.01.02',
      topRightIcon: _isDeleteMode
          ? GestureDetector(
        onTap: () => _togglePetSelection(index),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.red : Colors.grey,
              width: 2,
            ),
            color: isSelected ? Colors.red : Colors.transparent,
          ),
          child: isSelected
              ? const Icon(
            Icons.close,
            size: 16,
            color: Colors.white,
          )
              : null,
        ),
      )
          : null,
      onTap: _isDeleteMode ? () => _togglePetSelection(index) : null,
    );
  }
}

class _AddPetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => const PetTypCreatePage(),
        ));
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.f01,
            width: 1,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 24,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
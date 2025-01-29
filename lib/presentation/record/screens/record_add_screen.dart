import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saveit/core/theme/app_colors.dart';
import '../../widgets/category_selector/category_item.dart';
import '../../widgets/category_selector/category_selector_dialog.dart';

class RecordAddScreen extends StatefulWidget {
  final int initialTabIndex;

  const RecordAddScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<RecordAddScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordAddScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isMonthlyExpense = false;
  CategoryItem? _selectedCategory;

  final List<CategoryItem> _expenseCategories = [
    CategoryItem(
      id: 'cash',
      label: '대출',
      icon: Icons.account_balance_wallet,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      iconColor: AppColors.primary,
    ),
    CategoryItem(
      id: 'savings',
      label: '저축/투자',
      icon: Icons.savings,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      iconColor: AppColors.primary,
    ),
    // ... 나머지 카테고리 아이템들 추가
  ];

  final List<CategoryItem> _incomeCategories = [
    CategoryItem(
      id: 'salary',
      label: '급여',
      icon: Icons.payments,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      iconColor: AppColors.primary,
    ),
    // ... 나머지 수입 카테고리 아이템들 추가
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '현금 직접 입력',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: '수입'),
            Tab(text: '지출'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildIncomeInputForm(isExpense: false),
          _buildExpenseInputForm(isExpense: true),
        ],
      ),
    );
  }

  Widget _buildIncomeInputForm({required bool isExpense}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormLabel('수입명'),
            _buildTextField(
              hintText: '수입명을 입력해 주세요',
              controller: _memoController,
            ),
            SizedBox(height: 24.h),
            _buildFormLabel('수입 금액'),
            _buildTextField(
              hintText: '수입 금액을 입력해 주세요',
              controller: _amountController,
              keyboardType: TextInputType.number,
              suffix: const Text('원'),
            ),
            SizedBox(height: 24.h),
            _buildFormLabel('수입일시'),
            _buildDateSelector(),
            SizedBox(height: 24.h),
            _buildMonthlyExpenseToggle(isExpense),
            SizedBox(height: 24.h),
            _buildFormLabel('수입 카테고리'),
            _buildCategorySelector(),
            SizedBox(height: 24.h),
            _buildFormLabel('수입 메모'),
            _buildTextField(
              hintText: '메모를 입력해주세요',
              controller: _memoController,
              maxLines: 3,
            ),
            SizedBox(height: 40.h),
            _buildSubmitButton(isExpense),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseInputForm({required bool isExpense}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormLabel('지출명'),
            _buildTextField(
              hintText: '지출명을 입력해 주세요',
              controller: _memoController,
            ),
            SizedBox(height: 24.h),
            _buildFormLabel('지출 금액'),
            _buildTextField(
              hintText: '지출 금액을 입력해 주세요',
              controller: _amountController,
              keyboardType: TextInputType.number,
              suffix: const Text('원'),
            ),
            SizedBox(height: 24.h),
            _buildFormLabel('지출일시'),
            _buildDateSelector(),
            SizedBox(height: 24.h),
            if (isExpense) ...[
              _buildMonthlyExpenseToggle(isExpense),
              SizedBox(height: 24.h),
            ],
            _buildFormLabel('지출 수단'),
            _buildPaymentMethodSelector(),
            SizedBox(height: 24.h),
            _buildFormLabel('지출 카테고리'),
            _buildCategorySelector(),
            SizedBox(height: 24.h),
            _buildFormLabel('지출 메모'),
            _buildTextField(
              hintText: '메모를 입력해주세요',
              controller: _memoController,
              maxLines: 3,
            ),
            SizedBox(height: 40.h),
            _buildSubmitButton(isExpense),
          ],
        ),
      ),
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    TextInputType? keyboardType,
    Widget? suffix,
    int? maxLines,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16.sp,
        ),
        suffix: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_selectedDate.year}. ${_selectedDate.month.toString().padLeft(2, '0')}. ${_selectedDate.day.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.text,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyExpenseToggle(bool isExpense) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '매월 ${isExpense ? '지출' : '수입으'}로 등록',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.text,
          ),
        ),
        Switch(
          value: _isMonthlyExpense,
          onChanged: (value) {
            setState(() {
              _isMonthlyExpense = value;
            });
          },
          activeColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '현금',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.text,
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CategorySelectorDialog(
            title: '카테고리 선택',
            items: _tabController.index == 0 ? _incomeCategories : _expenseCategories,
            onSelect: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (_selectedCategory != null) ...[
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: _selectedCategory!.backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _selectedCategory!.icon,
                      color: _selectedCategory!.iconColor,
                      size: 14.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                ],
                Text(
                  _selectedCategory?.label ?? '카테고리 선택',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: _selectedCategory != null ? AppColors.text : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(bool isExpense) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: 저장 로직 구현
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          '저장하기',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
} 
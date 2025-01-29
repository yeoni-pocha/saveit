import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saveit/core/theme/app_colors.dart';
import 'package:saveit/presentation/widgets/section_card.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'SaveIt',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.notifications_none, color: AppColors.text),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.text),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildMonthSelector(),
              SizedBox(height: 20.h),
              _buildSummaryCard(),
              SizedBox(height: 20.h),
              _buildRegularPaymentSection(),
              SizedBox(height: 20.h),
              _buildFixedExpenseSection(),
              SizedBox(height: 20.h),
              _buildIncomeSection(),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {},
        ),
        Text(
          '2025년 1월',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '총 수입',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '0원',
                    style: TextStyle(
                      color: AppColors.incomeGreen,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '총 지출',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1,127,062원',
                    style: TextStyle(
                      color: AppColors.expenseRed,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegularPaymentSection() {
    return SectionCard(
      title: '고정지출',
      rows: [
        SectionRow(
          label: '지출 예정',
          value: '0원',
        ),
        SectionRow(
          label: '지출 완료',
          value: '75,900원',
        ),
      ],
    );
  }

  Widget _buildFixedExpenseSection() {
    return SectionCard(
      title: '변동지출',
      rows: [
        SectionRow(
          label: '지출 예정',
          value: '0원',
        ),
        SectionRow(
          label: '지출 완료',
          value: '1,051,162원',
          valueColor: AppColors.expenseRed,
        ),
      ],
    );
  }

  Widget _buildIncomeSection() {
    return SectionCard(
      title: '수입',
      trailing: TextButton(
        onPressed: () {
          // 수입 상세 페이지로 이동
        },
        child: Text(
          '더보기',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14.sp,
          ),
        ),
      ),
      rows: [
        SectionRow(
          label: '예상 수입',
          value: '0원',
        ),
        SectionRow(
          label: '실제 수입',
          value: '0원',
          valueColor: AppColors.incomeGreen,
        ),
      ],
    );
  }
} 
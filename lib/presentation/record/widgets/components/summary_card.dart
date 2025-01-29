import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saveit/core/theme/app_colors.dart';

class SummaryCard extends StatelessWidget {
  final String income;
  final String expense;

  const SummaryCard({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
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
              _buildAmountColumn('수입', income, AppColors.incomeGreen),
              _buildAmountColumn('지출', expense, AppColors.expenseRed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountColumn(String label, String amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
} 
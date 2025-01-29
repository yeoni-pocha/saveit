import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saveit/core/theme/app_colors.dart';

class TransactionItem extends StatelessWidget {
  final String category;
  final String date;
  final String amount;
  final IconData icon;
  final bool isExpense;

  const TransactionItem({
    super.key,
    required this.category,
    required this.date,
    required this.amount,
    required this.icon,
    required this.isExpense,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isExpense ? AppColors.expenseRed : AppColors.incomeGreen;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  date,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            isExpense ? '-$amount' : amount,
            style: TextStyle(
              color: iconColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 
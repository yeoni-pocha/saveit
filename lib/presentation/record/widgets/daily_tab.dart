import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/summary_card.dart';
import 'components/transaction_item.dart';

class DailyTab extends StatelessWidget {
  const DailyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SummaryCard(
          income: '2,500,000원',
          expense: '1,127,062원',
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            itemCount: 20,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final bool isExpense = index % 2 == 0;
              return TransactionItem(
                category: isExpense ? '식비' : '급여',
                date: '11월 ${index + 1}일',
                amount: isExpense ? '15,000원' : '2,500,000원',
                icon: isExpense ? Icons.restaurant : Icons.work,
                isExpense: isExpense,
              );
            },
          ),
        ),
      ],
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:saveit/core/theme/app_colors.dart';
import 'components/summary_card.dart';
import 'components/transaction_item.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _selectedDate = DateTime.now();
  final List<String> _weekDays = ['일', '월', '화', '수', '목', '금', '토'];

  // 임시 데이터
  final Map<DateTime, List<Transaction>> _events = {
    DateTime(2024, 1, 1): [Transaction(isExpense: true, amount: 2500, category: '식비', icon: Icons.restaurant)],
    DateTime(2024, 1, 2): [
      Transaction(isExpense: true, amount: 274980, category: '쇼핑', icon: Icons.shopping_bag),
    ],
    DateTime(2024, 1, 3): [
      Transaction(isExpense: true, amount: 94124, category: '교통', icon: Icons.directions_bus),
    ],
    DateTime(2024, 1, 29): [
      Transaction(isExpense: true, amount: 45000, category: '식비', icon: Icons.restaurant),
      Transaction(isExpense: false, amount: 1000000, category: '급여', icon: Icons.work),
    ],
    DateTime(2024, 1, 30): [
      Transaction(isExpense: true, amount: 75000, category: '쇼핑', icon: Icons.shopping_bag),
    ],
    DateTime(2024, 1, 31): [
      Transaction(isExpense: true, amount: 194310, category: '교통', icon: Icons.directions_bus),
    ],
  };

  List<DateTime> _getDaysInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    final days = <DateTime>[];

    // 첫 주의 시작일부터 마지막 주의 종료일까지 모든 날짜 생성
    for (var i = 1 - firstDay.weekday; i <= lastDay.day; i++) {
      days.add(DateTime(date.year, date.month, i));
    }
    return days;
  }

  void _changeMonth(int monthDelta) {
    if (mounted) {
      setState(() {
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month + monthDelta,
        );
      });
    }
  }

  void _selectDate(DateTime date) {
    if (mounted) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth(_selectedDate);

    return Column(
      children: [
        const SummaryCard(
          income: '1,000,000원',
          expense: '1,211,062원',
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, color: AppColors.text),
                      onPressed: () => _changeMonth(-1),
                    ),
                    Text(
                      '${_selectedDate.year}년 ${_selectedDate.month}월',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right, color: AppColors.text),
                      onPressed: () => _changeMonth(1),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _weekDays.map((day) {
                    final isWeekend = day == '일' || day == '토';
                    return SizedBox(
                      width: 40.w,
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isWeekend ? AppColors.expenseRed : AppColors.text,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                ),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  final isToday = isSameDay(day, DateTime.now());
                  final isSelected = isSameDay(day, _selectedDate);
                  final isWeekend = day.weekday == DateTime.sunday || day.weekday == DateTime.saturday;
                  final isCurrentMonth = day.month == _selectedDate.month;

                  final events = _events[day] ?? [];
                  double totalIncome = 0;
                  double totalExpense = 0;
                  for (var event in events) {
                    if (event.isExpense) {
                      totalExpense += event.amount;
                    } else {
                      totalIncome += event.amount;
                    }
                  }

                  return InkWell(
                    onTap: () => _selectDate(day),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
                        borderRadius: BorderRadius.circular(8.r),
                        border: isToday ? Border.all(color: AppColors.primary) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day.day.toString(),
                            style: TextStyle(
                              color: !isCurrentMonth
                                  ? AppColors.textSecondary
                                  : isWeekend
                                      ? AppColors.expenseRed
                                      : AppColors.text,
                              fontSize: 16.sp,
                              fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          if (totalExpense > 0) ...[
                            SizedBox(height: 4.h),
                            Text(
                              '-${NumberFormat('#,###').format(totalExpense)}',
                              style: TextStyle(
                                color: AppColors.expenseRed,
                                fontSize: 10.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          if (totalIncome > 0) ...[
                            SizedBox(height: 2.h),
                            Text(
                              '+${NumberFormat('#,###').format(totalIncome)}',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 10.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        if (_events[_selectedDate]?.isNotEmpty ?? false) ...[
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _events[_selectedDate]?.length ?? 0,
              itemBuilder: (context, index) {
                final transaction = _events[_selectedDate]![index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.divider),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction.category,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        transaction.isExpense
                            ? '-${NumberFormat('#,###').format(transaction.amount)}'
                            : '+${NumberFormat('#,###').format(transaction.amount)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: transaction.isExpense ? AppColors.expenseRed : AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

// 거래 내역을 위한 모델 클래스
class Transaction {
  final bool isExpense;
  final double amount;
  final String category;
  final IconData icon;

  Transaction({
    required this.isExpense,
    required this.amount,
    required this.category,
    required this.icon,
  });
} 
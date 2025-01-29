import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/section_card.dart';
import 'dart:math' show min;

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
              _buildExpenseSection(),
              SizedBox(height: 20.h),
              _buildCategoryExpenseCard(),
              SizedBox(height: 20.h),
              _buildIncomeSection(),
              SizedBox(height: 20.h),
              _buildSavingsSection(),
              SizedBox(height: 20.h),
              _buildInvestmentSection(),
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

  Widget _buildIncomeSection() {
    return SectionCard(
      title: '수입',
      rows: [
        SectionRow(
          label: '고정수입',
          value: '0원',
        ),
        SectionRow(
          label: '부수입',
          value: '75,900원',
        ),
        SectionRow(
          label: '금융수입',
          value: '75,900원',
        ),
      ],
    );
  }

  Widget _buildExpenseSection() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    radius: 20.r,
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '송서연님, 지난달보다',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.text,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '145,439원',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            ' 더 지출했습니다',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Stack(
                children: [
                  LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    lineHeight: 12.h,
                    percent: 1.0,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    progressColor: AppColors.primary.withOpacity(0.3),
                    barRadius: Radius.circular(6.r),
                  ),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        lineHeight: 12.h,
                        percent: min(1.0, 1.14 * _animationController.value),
                        backgroundColor: Colors.transparent,
                        progressColor: AppColors.primary,
                        barRadius: Radius.circular(6.r),
                        animation: true,
                        animationDuration: 1500,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '지난달 지출',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '1,065,623원',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.text,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '(114%)',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        SectionCard(
          title: '지출',
          rows: [
            SectionRow(
              label: '고정지출',
              value: '0원',
            ),
            SectionRow(
              label: '변동지출',
              value: '75,900원',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSavingsSection() {
    return SectionCard(
      title: '저축',
      rows: [
        SectionRow(
          label: '적금',
          value: '0원',
        ),
        SectionRow(
          label: '예금',
          value: '75,900원',
        ),
      ],
    );
  }

  Widget _buildInvestmentSection() {
    return SectionCard(
      title: '투자',
      rows: [
        SectionRow(
          label: '주식',
          value: '0원',
        ),
      ],
    );
  }

  Widget _buildCategoryExpenseCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '카테고리별 지출',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 200.h,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 60,
                    sections: [
                      PieChartSectionData(
                        value: 56,
                        color: const Color(0xFF6B4EFF),
                        title: '',
                        radius: 20 * _animationController.value,
                      ),
                      PieChartSectionData(
                        value: 14,
                        color: const Color(0xFFAE8FFF),
                        title: '',
                        radius: 20 * _animationController.value,
                      ),
                      PieChartSectionData(
                        value: 7.8,
                        color: const Color(0xFFFF6B6B),
                        title: '',
                        radius: 20 * _animationController.value,
                      ),
                      PieChartSectionData(
                        value: 7.5,
                        color: const Color(0xFFFF9F6B),
                        title: '',
                        radius: 20 * _animationController.value,
                      ),
                      PieChartSectionData(
                        value: 6.2,
                        color: const Color(0xFFFFB946),
                        title: '',
                        radius: 20 * _animationController.value,
                      ),
                      PieChartSectionData(
                        value: 3.2,
                        color: const Color(0xFFB4B4B4),
                        title: '',
                        radius: 20 * _animationController.value,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCategoryItem('쇼핑', '684,292원', '56%', const Color(0xFF6B4EFF)),
                  _buildCategoryItem('교통', '181,600원', '14%', const Color(0xFFAE8FFF)),
                  _buildCategoryItem('마트/편의점', '94,850원', '7.8%', const Color(0xFFFF6B6B)),
                  _buildCategoryItem('기타', '91,940원', '7.5%', const Color(0xFFFF9F6B)),
                  _buildCategoryItem('주거/통신', '75,900원', '6.2%', const Color(0xFFFFB946)),
                  _buildCategoryItem('외식', '39,200원', '3.2%', const Color(0xFFB4B4B4)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem(String label, String amount, String percentage, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      percentage,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Text(
                  amount,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:saveit/core/theme/app_colors.dart';
import 'components/summary_card.dart';

class WeeklyTab extends StatefulWidget {
  const WeeklyTab({super.key});

  @override
  State<WeeklyTab> createState() => _WeeklyTabState();
}

class _WeeklyTabState extends State<WeeklyTab> {
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _showChart = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SummaryCard(
            income: '0원',
            expense: '1,211,062원',
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '주간 수입:지출 요약',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '5주차는 수입보다 지출이\n194,310원 더 많아요',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 20.h),
                _buildChart(),
                SizedBox(height: 20.h),
                _buildWeeklyList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return AnimatedOpacity(
      opacity: _showChart ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        height: 200.h,
        child: BarChart(
          BarChartData(
            barGroups: _getBarGroups(),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt() + 1}주',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.sp,
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barTouchData: BarTouchData(enabled: false),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    final List<Map<String, double>> weeklyData = [
      {'income': 0, 'expense': 70340},
      {'income': 0, 'expense': 160160},
      {'income': 0, 'expense': 566710},
      {'income': 0, 'expense': 219542},
      {'income': 0, 'expense': 194310},
    ];

    return List.generate(weeklyData.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: weeklyData[index]['income']!,
            color: AppColors.primary,
            width: 8,
          ),
          BarChartRodData(
            toY: weeklyData[index]['expense']!,
            color: AppColors.expenseRed,
            width: 8,
          ),
        ],
      );
    });
  }

  Widget _buildWeeklyList() {
    final List<Map<String, String>> weeklyData = [
      {'week': '5주', 'date': '1.26 ~ 1.31', 'income': '0', 'expense': '194,310'},
      {'week': '4주', 'date': '1.19 ~ 1.25', 'income': '0', 'expense': '219,542'},
      {'week': '3주', 'date': '1.12 ~ 1.18', 'income': '0', 'expense': '566,710'},
      {'week': '2주', 'date': '1.5 ~ 1.11', 'income': '0', 'expense': '160,160'},
      {'week': '1주', 'date': '1.1 ~ 1.4', 'income': '0', 'expense': '70,340'},
    ];

    return Column(
      children: weeklyData.map((data) => _buildWeeklyItem(data)).toList(),
    );
  }

  Widget _buildWeeklyItem(Map<String, String> data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
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
                  data['week']!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  data['date']!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+${data['income']}원',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.incomeGreen,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '-${data['expense']}원',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.expenseRed,
                ),
              ),
            ],
          ),
          Icon(
            Icons.chevron_right,
            color: AppColors.textSecondary,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
} 
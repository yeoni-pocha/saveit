import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saveit/core/theme/app_colors.dart';
import 'package:saveit/presentation/plan/screens/plan_screen.dart';
import 'package:saveit/presentation/record/screens/record_screen.dart';
import 'package:saveit/presentation/report/screens/report_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _isExpanded = false;

  final _screens = [
    const PlanScreen(),
    const RecordScreen(),
    const ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          // 현재 화면이 기록 화면이 아닐 때만 FloatingActionButton 표시
          if (_currentIndex != 1) ...[
            Positioned(
              right: 16.w,
              bottom: 30.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_isExpanded) ...[
                    _buildExpandedButton(
                      label: '수입 추가',
                      icon: Icons.add,
                      color: AppColors.incomeGreen,
                      onTap: () {
                        setState(() => _isExpanded = false);
                        // 수입 탭(index: 0)으로 이동
                        context.push('/record', extra: 0);
                      },
                    ),
                    SizedBox(height: 12.h),
                    _buildExpandedButton(
                      label: '지출 추가',
                      icon: Icons.remove,
                      color: AppColors.expenseRed,
                      onTap: () {
                        setState(() => _isExpanded = false);
                        // 지출 탭(index: 1)으로 이동
                        context.push('/record', extra: 1);
                      },
                    ),
                    SizedBox(height: 12.h),
                  ],
                  FloatingActionButton(
                    onPressed: () {
                      setState(() => _isExpanded = !_isExpanded);
                    },
                    backgroundColor: AppColors.primary,
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: _isExpanded ? 0.125 : 0,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 28.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _isExpanded = false; // 탭 변경 시 확장 메뉴 닫기
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '플랜',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: '기록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '리포트',
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        FloatingActionButton.small(
          onPressed: onTap,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
      ],
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saveit/core/theme/app_colors.dart';
import '../widgets/daily_tab.dart';
import '../widgets/weekly_tab.dart';
import '../widgets/calendar_tab.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 48.h),
        child: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Text(
            '1월',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_today, color: AppColors.text, size: 20.sp),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search, color: AppColors.text, size: 20.sp),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: '일일'),
              Tab(text: '주간'),
              Tab(text: '달력'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DailyTab(),
          WeeklyTab(),
          CalendarTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/record/add'),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white, size: 24.sp),
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saveit/core/theme/app_colors.dart';

class SectionRow {
  final String label;
  final String value;
  final Color? valueColor;
  final VoidCallback? onTap;

  const SectionRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.onTap,
  });
}

class SectionCard extends StatelessWidget {
  final String title;
  final List<SectionRow> rows;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? trailing; // 섹션 타이틀 옆에 추가할 위젯 (옵션)

  const SectionCard({
    super.key,
    required this.title,
    required this.rows,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            if (trailing != null) ...[
              const Spacer(),
              trailing!,
            ],
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: padding ?? EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.surface,
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          ),
          child: Column(
            children: rows.map((row) => _buildRow(row)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(SectionRow row) {
    return InkWell(
      onTap: row.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              row.label,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 16.sp,
              ),
            ),
            Text(
              row.value,
              style: TextStyle(
                color: row.valueColor ?? AppColors.text,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
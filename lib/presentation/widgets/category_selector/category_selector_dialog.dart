import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saveit/core/theme/app_colors.dart';
import 'category_item.dart';

class CategorySelectorDialog extends StatelessWidget {
  final String title;
  final List<CategoryItem> items;
  final Function(CategoryItem) onSelect;

  const CategorySelectorDialog({
    super.key,
    required this.title,
    required this.items,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Flexible(
                child: SingleChildScrollView(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 20.h,
                    crossAxisSpacing: 20.w,
                    childAspectRatio: 0.8,
                    children: items.map((item) => _buildCategoryItem(context, item)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryItem item) {
    return InkWell(
      onTap: () {
        onSelect(item);
        Navigator.pop(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: item.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              color: item.iconColor,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Flexible(
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.text,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
} 
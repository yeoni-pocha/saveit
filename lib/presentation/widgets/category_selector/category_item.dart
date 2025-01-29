import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const CategoryItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
} 
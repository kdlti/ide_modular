import 'package:flutter/material.dart';

class MenuUserData {
  const MenuUserData({
    required this.title,
    this.route,
    this.icon,
    this.onTap,
    this.children = const [],
  });

  final String title;
  final String? route;
  final IconData? icon;
  final VoidCallback? onTap;
  final List<MenuUserData> children;
}

import 'package:badges/badges.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:ide_modular/src/data/menu_user_data.dart';
import '../utils/constants.dart';


abstract class SideMenuItemData {
  const SideMenuItemData();
}

class SideMenuItemDataTileDrag extends SideMenuItemData {
  final List<MenuUserData> items;
  final int index;
  final void Function(bool) onTap;
  final void Function(MenuUserData item)? onSelected;
  final String selectedRoute;
  final int depth;
  final Color? iconColor;
  final Color? activeIconColor;
  final TextStyle textStyle;
  final TextStyle activeTextStyle;
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final Color borderColor;
  bool get isLast => index == items.length - 1;

  const SideMenuItemDataTileDrag({
    required this.onTap,
    required this.items,
    required this.index,
    this.onSelected,
    required this.selectedRoute,
    this.depth = 0,
    this.iconColor = Colors.red,
    this.activeIconColor,
    this.textStyle = const TextStyle(fontSize: 12, color: Colors.black),
    this.activeTextStyle = const TextStyle(fontSize: 12, color: Colors.black),
    this.backgroundColor = Colors.red,
    this.activeBackgroundColor = Colors.red,
    this.borderColor = Colors.black,
  });
}

class SideMenuItemDataTile extends SideMenuItemData {
  SideMenuItemDataTile({
    this.backgroundColor, 
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.title,
    this.titleStyle,
    this.selectedTitleStyle,
    this.tooltip,
    this.badgeContent,
    this.hasSelectedLine = false,
    this.selectedLineSize = const Size(
      Constants.itemSelectedLineWidth,
      Constants.itemSelectedLineHeight,
    ),
    this.itemHeight = Constants.itemHeight,
    this.margin = Constants.itemMargin,
    this.borderRadius,
    this.selectedIcon,
    this.highlightSelectedColor,
    this.hoverColor,
    this.badgePosition,
    this.badgeStyle,
  })  : assert(itemHeight >= 0.0),
        assert(icon != null || title != null),
        super();

  final bool isSelected, hasSelectedLine;
  final void Function() onTap;
  final Size selectedLineSize;
  final String? title;
  final TextStyle? titleStyle;
  final TextStyle? selectedTitleStyle;
  final String? tooltip;
  final Widget? badgeContent;
  final BadgePosition? badgePosition;
  final BadgeStyle? badgeStyle;
  final Widget? icon;
  final Widget? selectedIcon;
  final double itemHeight;
  final EdgeInsetsDirectional margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? hoverColor, highlightSelectedColor;
  final Color? backgroundColor;
}

class SideMenuItemDataTitle extends SideMenuItemData {
  const SideMenuItemDataTitle({
    required this.title,
    this.titleStyle,
    this.textAlign,
    this.padding = Constants.itemMargin,
  }) : super();

  final String title;
  final TextStyle? titleStyle;
  final TextAlign? textAlign;
  final EdgeInsetsDirectional padding;
}

class SideMenuItemDataDivider extends SideMenuItemData {
  const SideMenuItemDataDivider({
    required this.divider,
    this.padding = Constants.itemMargin,
  }) : super();

  final Divider divider;
  final EdgeInsetsDirectional padding;
}

class FluentTreeViewItemData extends SideMenuItemData {
  final List<fluent_ui.TreeViewItem> treeViewItems;

  FluentTreeViewItemData(this.treeViewItems);
}
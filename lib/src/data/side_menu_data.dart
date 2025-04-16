import 'package:flutter/material.dart';

import 'side_menu_item_data.dart';

class SideMenuData {
  final Widget? customChild, header, footer;
  final List<SideMenuItemData>? items;

  const SideMenuData({
    this.customChild,
    this.header,
    this.footer,
    this.items,
  }) : assert(customChild != null || items != null);
}

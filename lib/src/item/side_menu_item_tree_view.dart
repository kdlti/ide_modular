import 'package:flutter/material.dart';

import '../data/menu_user_data.dart';
import '../data/side_menu_item_data.dart';

class SideMenuItemTreeView extends StatelessWidget {
  final SideMenuItemDataTileDrag data;

  const SideMenuItemTreeView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.depth > 0 && data.isLast) {
      return _buildTiles(context, data.items[data.index]);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: data.borderColor,
          ),
        ),
      ),
      child: _buildTiles(context, data.items[data.index]),
    );
  }

  Widget _buildTiles(BuildContext context, MenuUserData item) {
    bool selected = _isSelected(data.selectedRoute, [item]);

    if (item.children.isEmpty) {
      return ListTile(
        contentPadding: _getTilePadding(data.depth),
        leading: _buildIcon(item.icon, selected),
        title: _buildTitle(item.title, selected),
        selected: selected,
        tileColor: data.backgroundColor,
        selectedTileColor: data.activeBackgroundColor,
        onTap: () {
          if (data.onSelected != null) {
            data.onSelected!(item);
          }
        },
      );
    }

    final childrenTiles = item.children.map((child) {
      return SideMenuItemTreeView(
        data: data,
      );
    }).toList();

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        onExpansionChanged: (value) {
          data.onTap(value);
        },
        tilePadding: _getTilePadding(data.depth),
        leading: _buildIcon(item.icon),
        title: _buildTitle(item.title),
        initiallyExpanded: selected,
        children: childrenTiles,
      ),
    );
  }

  bool _isSelected(String route, List<MenuUserData> items) {
    for (final item in items) {
      if (item.route == route) {
        return true;
      }
      if (item.children.isNotEmpty) {
        return _isSelected(route, item.children);
      }
    }
    return false;
  }

  Widget _buildIcon(IconData? icon, [bool selected = false]) {
    return icon != null
        ? Icon(
            icon,
            size: 22,
            color: selected
                ? data.activeIconColor ?? data.activeTextStyle.color
                : data.iconColor ?? data.textStyle.color,
          )
        : const SizedBox();
  }

  Widget _buildTitle(String title, [bool selected = false]) {
    return Text(
      title,
      style: selected ? data.activeTextStyle : data.textStyle,
    );
  }

  EdgeInsets _getTilePadding(int depth) {
    return EdgeInsets.only(
      left: 10.0 + 10.0 * depth,
      right: 10.0,
    );
  }
}

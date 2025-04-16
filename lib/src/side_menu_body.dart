import 'package:fluent_ui/fluent_ui.dart';

import 'data/side_menu_data.dart';
import 'data/side_menu_item_data.dart';
import 'item/export.dart';
import 'item/side_menu_item_tree_view.dart';

///Constrói o corpo do meu menu.
class SideMenuBody extends StatelessWidget {
  final bool isOpen;
  final double minWidth;
  final SideMenuData data;

  const SideMenuBody({
    Key? key,
    required this.minWidth,
    required this.isOpen,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (data.header != null) data.header!,
      if (data.customChild != null) Expanded(child: data.customChild!),
      if (data.items != null)
        Expanded(
          child: ListView.builder(
            controller: ScrollController(),
            itemCount: data.items!.length,
            itemBuilder: (context, index) {
              final SideMenuItemData item = data.items![index];
              if (item is SideMenuItemDataTile) {
                return SideMenuItemTile(
                  minWidth: minWidth,
                  isOpen: isOpen,
                  data: item,
                );
              } else if (item is SideMenuItemDataTileDrag) {
                return SideMenuItemTreeView(
                  data: item,
                );
              } else if (item is SideMenuItemDataTitle) {
                return SideMenuItemTitle(
                  data: item,
                );
              } else if (item is SideMenuItemDataDivider) {
                return SideMenuItemDivider(
                  data: item,
                );
              } else if (item is FluentTreeViewItemData) {
                return TreeView(
                  items: item.treeViewItems,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      if (data.footer != null) data.footer!,
    ]);
  }
}

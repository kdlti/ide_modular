import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ide_modular/export.dart';
import 'package:menu_modular/export.dart';

import 'data_class.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SideMenuIde(),
    ),
  );
}

class SideMenuIde extends StatefulWidget {
  final Widget? customChild;
  final Widget? child;
  const SideMenuIde({
    super.key,
    this.child,
    this.customChild,
  });

  @override
  State<SideMenuIde> createState() => _SideMenuIdeState();
}

class _SideMenuIdeState extends State<SideMenuIde> {
  late SideMenuController controller;
  int selectedIndex = 1;

  @override
  void initState() {
    controller = SideMenuController();
    super.initState();
    selectedIndex = 1;
    // selectedIndex = calculateSelectedIndex();
  }

  int calculateSelectedIndex() {
    final String location = Get.previousRoute;
    if (location.startsWith('/dashboard')) {
      return 0;
    }
    if (location.startsWith('/tableAr')) {
      return 1;
    }
    if (location.startsWith('/producao')) {
      return 2;
    }
    if (location.startsWith('/simcard')) {
      return 3;
    }
    return 0;
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Get.toNamed('/dashboard');
        break;
      case 1:
        Get.toNamed('/tableAr');
        break;
      case 2:
        Get.toNamed('/producao');
        break;
      case 3:
        Get.toNamed('/simcard');
        break;
    }
  }

  bool isMenuVisible = false;
  EnumActions? selectedAction;

  void toggleMenu() {
    setState(() {
      isMenuVisible = !isMenuVisible;
    });
  }

  void setAction(EnumActions action) {
    setState(() {
      selectedAction = action;
    });
  }

  Client? teste;

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size.width;
    return fluent.FluentApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                SideMenu(
                  maxWidth: 150,
                  hasResizer: false,
                  mode:
                      screen < 1200 ? SideMenuMode.compact : SideMenuMode.open,
                  hasResizerToggle: false,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  builder: (data) {
                    return SideMenuData(
                      items: [
                        const SideMenuItemDataDivider(
                          divider: Divider(
                            indent: 10,
                            endIndent: 10,
                            height: 5,
                            color: Color.fromARGB(255, 197, 197, 197),
                          ),
                        ),
                        FluentTreeViewItemData(
                          [
                            fluent.TreeViewItem(
                              expanded: false,
                              content: const Text(
                                "Manutenção",
                                overflow: TextOverflow.ellipsis,
                              ),
                              children: [
                                fluent.TreeViewItem(
                                  content: const Text("Em Andamento",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Atrasados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Finalizados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            fluent.TreeViewItem(
                              expanded: false,
                              content: const Text("Produção",
                                  overflow: TextOverflow.ellipsis),
                              children: [
                                fluent.TreeViewItem(
                                  content: const Text("Em Andamento",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Atrasados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Finalizados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            fluent.TreeViewItem(
                              expanded: false,
                              content: const Text("Simcards",
                                  overflow: TextOverflow.ellipsis),
                              children: [
                                fluent.TreeViewItem(
                                  content: const Text("Em Andamento",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Atrasados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Finalizados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                      footer: UserMenu(
                        data: [
                          MenuUserData(
                            icon: Icons.info,
                            title: "Sobre",
                            onTap: () => toggleMenu(),
                          ),
                          MenuUserData(
                            icon: Icons.info,
                            title: "Teste",
                            onTap: () => print("teste"),
                          )
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ElevatedButton(
                    child: const Text("Click"),
                    onPressed: () => {
                      teste = Client(
                        name: "Eduardo",
                        address: "maksmckamc N9",
                        email: "Eduardo@gmail.com",
                        phone: "11953751486",
                      ),
                      controller.toggle(),
                      _switchViews(EnumActions.none),
                    },
                  ),
                ),
                SideMenu(
                  maxWidth: 350,
                  hasResizer: false,
                  controller: controller,
                  hasResizerToggle: true,
                  resizerToggleData: ResizerToggleData(
                    controller: () => _switchViews(EnumActions.none),
                    topPosition: 30,
                  ),
                  position: SideMenuPosition.right,
                  mode: screen < 1200 ? SideMenuMode.compact : SideMenuMode.open,
                  builder: (data) => SideMenuData(
                    header: SimpleIconButton(
                      maxWidth: 50,
                      minWidth: 100,
                      options: [
                        OptionItem(
                          isPopUp: true,
                          id: "1",
                          value: "Teste",
                          icon: Icons.add,
                          onPressed: () => {},
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'incluirSimuc',
                              child: const Text('Incluir Simuc'),
                              onTap: () {
                                controller.open();
                                _switchViews(EnumActions.add);
                              },
                            ),
                            PopupMenuItem<String>(
                              value: 'incluirSrecuperacao',
                              child: const Text('Incluir S/ Recuperação'),
                              onTap: () {
                                controller.open();
                                _switchViews(EnumActions.edit);
                              },
                            ),
                          ],
                        ),
                        OptionItem(
                          id: "1",
                          value: "Teste",
                          icon: Icons.refresh,
                          onPressed: () => {
                            controller.open(),
                            _switchViews(EnumActions.refresh),
                          },
                        ),
                        OptionItem(
                          id: "1",
                          value: "Teste",
                          icon: Icons.edit,
                          onPressed: () => {
                            controller.open(),
                            _switchViews(EnumActions.edit),
                          },
                        ),
                        OptionItem(
                          id: "1",
                          value: "Teste",
                          icon: Icons.delete,
                          onPressed: () => {
                            controller.open(),
                            _switchViews(EnumActions.delete),
                          },
                        )
                      ],
                    ),
                    customChild: selectedWidget,
                  ),
                ),
              ],
            ),
            if (isMenuVisible)
              MenuContext(
                width: 800,
                height: 500,
                func: () => toggleMenu(),
                label: "versão",
                customChildren: Text("S"),
              ),
          ],
        ),
      ),
    );
  }

  Widget selectedWidget = Container();

  void _switchViews(EnumActions activeView) {
    setState(() {
      switch (activeView) {
        case EnumActions.none:
          selectedWidget = Container();
          break;
        case EnumActions.add:
          selectedWidget = Container(
            width: 200,
            height: 100,
            color: Colors.red,
          );
          break;
        case EnumActions.refresh:
          selectedWidget = Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          );
          break;
        case EnumActions.edit:
          selectedWidget = Container(
            width: 100,
            height: 100,
            color: Colors.green,
          );
          break;
        case EnumActions.delete:
          selectedWidget = Container(
            width: 100,
            height: 100,
            color: Colors.black,
          );
          break;
      }
    });
  }
}

enum EnumActions { none, refresh, add, edit, delete }


// MenuFormBody(
//                       data: MenuFormData(
//                         paddingHorizontalHeader: 5,
//                         paddingExternalHeader:
//                             const EdgeInsets.only(bottom: 0.0),
//                         headerButtons: [
//                           HeaderRowDataButtons(
//                             onPressed: () => controller.open(),
//                             icon: const Icon(Icons.add),
//                             backgroundColor: Colors.red,
//                           ),
//                           HeaderRowDataButtons(
//                             onPressed: () => print("02"),
//                             icon: const Icon(Icons.refresh),
//                             backgroundColor: Colors.green,
//                           ),
//                           TextHeaderRowDataButtons(
//                               onTap: () {}, title: "Teste1")
//                         ],
//                         buttons: [
//                           MenuFormItemDataTile(
//                             title: "Incluir",
//                             icon: const Icon(Icons.add_box_outlined),
//                             onTap: () {},
//                           ),
//                           MenuFormItemDataTile(
//                               title: "Editar aaaaaaSIMUC",
//                               icon: const Icon(Icons.place),
//                               onTap: () {}),
//                           MenuFormItemDataTile(
//                               title: "Exportar Relatório",
//                               icon: const Icon(Icons.play_arrow),
//                               onTap: () {}),
//                           MenuFormItemDataTile(
//                             title: "Excluir SIMUC",
//                             icon: const Icon(Icons.cabin),
//                             onTap: () {},
//                           ),
//                         ],
//                       ),
//                     ),
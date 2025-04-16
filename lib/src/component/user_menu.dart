import 'package:flutter/material.dart';
import 'package:ide_modular/export.dart';

class UserMenu extends StatefulWidget {
  final List<MenuUserData> data;
  const UserMenu({super.key, required this.data});

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: PopupMenuButton<MenuUserData>(
        tooltip: "Configurações",
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 4,
        offset: const Offset(0, 50),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: const Icon(
          Icons.settings,
          size: 40,
        ),
        itemBuilder: (context) {
          return widget.data.map((MenuUserData item) {
            return PopupMenuItem<MenuUserData>(
              value: item,
              onTap: item.onTap,
              child: Row(
                children: [
                  Icon(
                    item.icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}

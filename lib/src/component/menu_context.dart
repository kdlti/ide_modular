import 'package:flutter/material.dart';

class MenuContext extends StatelessWidget {
  final VoidCallback func;
  final String label;
  final double? labelSize;
  final double? width;
  final double? height;
  final Widget customChildren;
  const MenuContext({
    super.key,
    required this.func,
    required this.label,
    required this.width,
    required this.height,
    required this.customChildren,
    this.labelSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            width: width,
            height: height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      disabledColor: Colors.transparent,
                      onPressed: func,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 50),
                customChildren
              ],
            ),
          ),
        ),
      ),
    );
  }
}

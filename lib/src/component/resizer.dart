import 'package:flutter/material.dart';

import '../data/resizer_data.dart';
import '../utils/constants.dart';

///Classe que cria o resizer
class Resizer extends StatefulWidget {
  final ResizerData data;
  final Decoration? decoration;
  final Function(DragUpdateDetails details) onPanUpdate;

  const Resizer({
    Key? key,
    this.decoration,
    ResizerData? data,
    required this.onPanUpdate,
  })  : data = data ?? const ResizerData(),
        super(key: key);

  @override
  State<Resizer> createState() => _ResizerState();
}

class _ResizerState extends State<Resizer> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
  }

  _handleUpdate(DragUpdateDetails details) {
    widget.onPanUpdate(details);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onPanUpdate: _handleUpdate,
        child: InkWell(
          mouseCursor: SystemMouseCursors.resizeLeftRight,
          onTap: () {},
          onHover: (hover) {
            setState(() {
              _visible = hover;
            });
          },
          child: AnimatedContainer(
            color: _visible
                ? widget.data.resizerHoverColor
                : widget.data.resizerColor,
            duration: Constants.duration,
            width: widget.data.resizerWidth,
            // height: MediaQuery.of(context).size.height,
            height: 620,
          ),
        ),
      ),
    );
  }
}

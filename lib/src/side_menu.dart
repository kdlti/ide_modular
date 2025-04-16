import 'package:flutter/material.dart';
import 'package:ide_modular/src/component/resizer.dart';

import 'component/resizer_toggle.dart';
import 'data/resizer_data.dart';
import 'data/resizer_toggle_data.dart';
import 'data/side_menu_builder_data.dart';
import 'data/side_menu_data.dart';
import 'side_menu_body.dart';
import 'side_menu_controller.dart';
import 'side_menu_mode.dart';
import 'side_menu_position.dart';
import 'side_menu_priority.dart';
import 'side_menu_width_mixin.dart';
import 'utils/constants.dart';

/// Signature for the `builder` function which take the `SideMenuBuilderData`
/// is responsible for returning a widget which is to be rendered.
typedef SideMenuBuilder = SideMenuData Function(SideMenuBuilderData data);

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
    this.decoration,
    required this.builder,
    this.controller,
    this.mode = SideMenuMode.auto,
    this.priority = SideMenuPriority.mode,
    this.position = SideMenuPosition.left,
    this.minWidth = Constants.minWidth,
    this.maxWidth = Constants.maxWidth,
    this.hasResizer = true,
    this.hasResizerToggle = true,
    this.resizerData,
    this.resizerToggleData,
    this.backgroundColor,
  })  : assert(minWidth >= 0.0),
        assert(maxWidth > 0.0),
        /**
         * Está verificando se priority é igual a SideMenuPriority.sizer. Se for, 
         * a condição hasResizer será verificada. Se hasResizer for verdadeiro, o assert não fará 
         * nada (porque a condição é verdadeira). Se hasResizer for falso, o assert será ativado.
         */
        assert(priority == SideMenuPriority.sizer ? hasResizer : true),
        assert(resizerData != null ? hasResizer : true),
        assert(resizerToggleData != null ? hasResizerToggle : true),
        super(key: key);

  /// The [builder] function which will be invoked on each widget build.
  /// The [builder] takes the `SideMenuBuilderData` and must return
  /// a [SideMenuData] that includes headers, footers, items, or custom child.
  ///
  /// You must provide items or customChild.
  ///
  /// ```dart
  /// SideMenu(
  ///   builder: (data) => SideMenuData(
  ///     header: Container(
  ///     items: [
  ///       SideMenuItemData(
  ///         isSelected: true,
  ///         onTap: () {},
  ///         title: 'Item 1',
  ///         icon: Icons.home,
  ///       ),
  ///     ],
  ///     footer: const Text('Footer'),
  ///   ),
  /// ),
  /// ```dart
  final SideMenuBuilder builder;
  final Decoration? decoration;

  /// The [controller] that can be used to open, close, or toggle side menu.
  final SideMenuController? controller;

  /// The [SideMenuMode] which is auto, open or compact.
  ///
  /// In [SideMenuMode.auto], the side menu is visible when the screen is
  /// wide enough and changes to compact mode when the screen is narrow.
  ///
  /// In [SideMenuMode.compact], the side menu closed based on [minWidth] value.
  ///
  /// In [SideMenuMode.open], the side menu opens based on [maxWidth] value.
  final SideMenuMode mode;

  /// The [SideMenuPriority] which is mode or sizer.
  ///
  /// In [SideMenuPriority.mode], the side menu width change based on [mode]
  /// value.
  ///
  /// In [SideMenuPriority.sizer], the side menu width not change if user set
  /// custom size with [Resizer].
  /// meaning of custom size is size that user want
  /// and it's opposing [minWidth] and [maxWidth] values.
  ///
  /// The [SideMenuPriority.sizer] available only if [hasResizer] is true.
  final SideMenuPriority priority;

  /// The [SideMenuPosition] which is left or right.
  final SideMenuPosition position;

  /// The [minWidth] and [maxWidth] values which are used to determine the
  /// side menu width.
  ///
  /// The [minWidth] value is used to determine the side menu width in the
  /// smallest case.
  ///
  /// It's used to determine the side menu width in [SideMenuMode.open] or
  /// [SideMenuMode.auto].
  ///
  /// The [maxWidth] value is used to determine the side menu width in the
  /// largest case
  ///
  /// It's used to determine the side menu width in [SideMenuMode.compact]
  /// or [SideMenuMode.auto].
  final double minWidth, maxWidth;

  /// The [hasResizer] enable [Resizer] widget for side menu.
  /// With [Resizer] the side menu width can be customized by the user.
  final bool hasResizer;

  /// The [ResizerData] that can set custom style for a [Resizer].
  final ResizerData? resizerData;

  /// The [hasResizerToggle] enable [ResizerToggle] widget for side menu.
  /// With [ResizerToggle] button you can toggle the width of the side menu
  /// between [minWidth] or [maxWidth].
  final bool hasResizerToggle;

  /// The [resizerToggleData] that can set custom style for a [ResizerToggle].
  final ResizerToggleData? resizerToggleData;

  /// The [backgroundColor] it's used to determine the side menu background
  /// color.
  final Color? backgroundColor;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with SideMenuWidthMixin {
  double _currentWidth = Constants.zeroWidth;

  ///Inicaliza a minha aplicação passando as funções para o controller
  ///caso [widget.controller] for diferente de nulo irá executar a função
  /// #### widget.controller?.open = _openMenu: Recebe a função [_openMenu]
  /// #### widget.controller?.close = _openMenu: Recebe a função [_closeMenu]
  /// #### widget.controller?.toggle = _openMenu: Recebe a função [_toggleMenu]
  /// - super.intiState() = Garante que qualquer inicialização necessária no widget
  /// pai seja concuída antes de prosseguir
  /// com a inicialização do estado do widget filho
  @override
  void initState() {
    if (widget.controller != null) {
      widget.controller?.open = _openMenu;
      widget.controller?.close = _closeMenu;
      widget.controller?.toggle = _toggleMenu;
    }
    super.initState();
  }

  ///Ao ser chamada abre o menu
  ///#### Variáveis:
  /// - `_currentWidth` recebe o valor de `widget.maxWidth` que é o valor máximo
  /// definido.
  void _openMenu() {
    setState(() {
      _currentWidth = widget.maxWidth;
    });
  }

  ///Ao ser chamada fecha o menu
  ///#### Variáveis:
  /// - `_currentWidth` recebe o valor de `widget.minWidth` que é o valor mínimo definido
  /// para o fechamento do menu.
  void _closeMenu() {
    setState(() {
      _currentWidth = widget.minWidth;
    });
  }

  ///Ao ser chamado alterna entre o fechamento e abertura do menu
  ///#### Lógica:
  /// - Caso o valor de `_currentWidth` for igual ao valor de `widget.minWidth`, será considerado uma lógica verdadeira
  /// logo o `_currentWidth` receberá `widget.maxWidth`, caso o valor de `_currentWidth` e `widget.minWidth` forem diferentes
  /// `_currentWidth` receberá `widget.minWidth`
  void _toggleMenu() {
    setState(() {
      _currentWidth =
          _currentWidth == widget.minWidth ? widget.maxWidth : widget.minWidth;
    });
  }

  ///Função que avisa quando algo muda ou seja ele notifica o widget de que algo que ele precisa mudou
  ///e se atualiza de acordo é comom se fosse um listener(ouvinte), neste caso sempre que as dependências
  ///deste widget mudarem o flutter chamará automaticamente o método [didChangeDependencies] e, nesse ponto,
  ///a função [_calculateMenuWidthSize] será executada.
  @override
  void didChangeDependencies() {
    _calculateMenuWidthSize();
    super.didChangeDependencies(); //Mamtém o comportamentento padrão do método
  }

  ///Função que calcula o tamanho da largura do menu
  ///[_currentWidth] recebe o retorno do tipo `double` do mixin [calculateWidthSize]
  ///quando instâncio `calculateWidthSize`, passo os valores do meu construtor par aos parâmetros
  ///de `calculateWidthSize`
  void _calculateMenuWidthSize() {
    _currentWidth = calculateWidthSize(
      priority: widget.priority,
      hasResizer: widget.hasResizer,
      minWidth: widget.minWidth,
      maxWidth: widget.maxWidth,
      currentWidth: _currentWidth,
      mode: widget.mode,
      deviceWidth: MediaQuery.of(context).size.width,
    );
  }

  ///`covariant` é usada para permitir que o método `didUpdateWidget`, aceite um tipo
  ///específico de widget(neste caso, `SideMenu`) ou um tipo que seja uma subclasse de `Sidemenu`,
  ///tornando o código mais flexível e adaptável a diferentes tipos de widgets
  @override
  void didUpdateWidget(covariant SideMenu oldWidget) {
    if (oldWidget.mode != widget.mode ||
        oldWidget.priority != widget.priority ||
        oldWidget.hasResizer != widget.hasResizer ||
        oldWidget.minWidth != widget.minWidth ||
        oldWidget.maxWidth != widget.maxWidth) {
      _calculateMenuWidthSize();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => _createView();

  ///Função `_createView`
  ///#### Lógica:
  /// - Se `widget.hasResizer` ou `widget.hasResizerToggle` for true entra na condição,
  /// caso seja false retorna `content`
  /// - Se `widget.hasResizer` e `widget.hasResizerToggle` forem true ele retorna `_hasResizerToggle`,
  /// senão se `widget.hasResizer` somente este cara for verdadeiro ele retorna `_hasResizer(child: content)`
  /// senão retorna `_hasResizerToggle(child: content)`
  ///
  Widget _createView() {
    //Pega o tamanho atual da minha tela ex: 1920 x 945
    final size = MediaQuery.of(context).size;
    /*
    recebendo o widget AnimatedContainer(duration: 100ms, BoxConstraints(w=50.0, h=945.0), clipBehavior: Clip.none)
     ao fazer um resize nos meus menus o content recebe esse widget, ele contém a duração da animação,
    os constraints de tamanho e o clipBehavior
    */
    final content = _content(size);

    if (widget.hasResizer || widget.hasResizerToggle) {
      if (widget.hasResizer && widget.hasResizerToggle) {
        return _hasResizerToggle(
          child: _hasResizer(child: content),
        );
      } else if (widget.hasResizer) {
        return _hasResizer(child: content);
      } else {
        return _hasResizerToggle(child: content);
      }
    } else {
      return content;
    }
  }

  ///`_content` retorna o conteúdo do meu menu
  ///#### Parâmento:
  /// - Size: Recebe o tamanho atual da minha tela
  Widget _content(Size size) {
    return AnimatedContainer(
            decoration: widget.decoration,
            duration: Constants.duration,
            width: _currentWidth,
            color:
                widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
            constraints: BoxConstraints(
              minHeight: size.height,
              maxHeight: size.height,
              minWidth: widget.minWidth,
              maxWidth: widget.maxWidth,
            ),
            //Constrói o meu Menu
            child: SideMenuBody(
              isOpen: _currentWidth != widget.minWidth,
              minWidth: widget.minWidth,
              data: _builder(),
            ),
          );
  }

  /// A função `_buider` retorna um `SideMenuData`
  SideMenuData _builder() {
    return widget.builder(SideMenuBuilderData(
      currentWidth: _currentWidth,
      minWidth: widget.minWidth,
      maxWidth: widget.maxWidth,
      //Se a `_currentWidth` for diferente da `widget.minWidth` retorna true
      isOpen: _currentWidth != widget.minWidth,
    ));
  }

  ///Função que cria a barra de `_resizer`, ele retorna um widget de Resizer
  Widget _resizer() {
    return Resizer(
      data: widget.resizerData,
      onPanUpdate: (details) {
        // print("details => $details");
        late final double x;
        if (widget.position == SideMenuPosition.left) {
          //dx: me retorna a posição X(Horizontal)
          x = details.globalPosition.dx;
        } else {
          x = MediaQuery.of(context).size.width - details.globalPosition.dx;
        }
        if (x >= widget.minWidth && x <= widget.maxWidth) {
          setState(() {
            _currentWidth = x;
          });
        } else if (x < Constants.minWidth && _currentWidth != widget.minWidth) {
          setState(() {
            _currentWidth = widget.minWidth;
          });
        } else if (x > Constants.maxWidth && _currentWidth != widget.maxWidth) {
          setState(() {
            _currentWidth = widget.maxWidth;
          });
        }
      },
    );
  }

  ///Função que retorna umm Widget e espera receber um
  ///#### Parâmetro:
  /// - child: child deve ser um widget
  ///
  /// Ele cria uma row onde é encaixado o widget criado na função `_content`
  ///
  ///`SideMenuPosition` define em que posição o _resizer deve ficar no meu menu
  Widget _hasResizer({required Widget child}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.position == SideMenuPosition.right) _resizer(),
        child,
        if (widget.position == SideMenuPosition.left) _resizer(),
      ],
    );
  }

  Widget _resizerToggle() {
    return ResizerToggle(
      data: widget.resizerToggleData,
      rightArrow: _currentWidth == widget.minWidth,
      leftPosition: widget.position == SideMenuPosition.left,
      onTap: () => _toggleMenu(),
    );
  }

  Widget _hasResizerToggle({required Widget child}) {
    return Stack(
      alignment: widget.position == SideMenuPosition.left
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      children: [
        child,
        _resizerToggle(),
      ],
    );
  }
}

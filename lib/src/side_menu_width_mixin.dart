

import 'side_menu_mode.dart';
import 'side_menu_priority.dart';
import 'utils/constants.dart';
import 'utils/device_screen_type.dart';

///Um mixin em Flutter é uma técnica de programação que permite reutilizar
/// código em diferentes partes do seu aplicativo. Ele agrupa funcionalidades
/// comuns em uma única classe que pode ser aplicada a outras classes, ajudando
///  a manter o código organizado, reduzir a repetição e facilitar a manutenção.
/// Essa abordagem é útil para adicionar comportamentos específicos a várias classes
/// sem herança direta, o que pode ser benéfico em cenários onde funcionalidades de
/// diferentes fontes precisam ser estendidas.

/// - `late` palavra chave utilizada para declarar variáveis que não precisam ser
///inicializadas imediatamente

mixin SideMenuWidthMixin {
  ///[mode] define o modo de como os menus ficam abertos ou fechados quando a aplicação é iniciada
  /// - `SideMenuMode.auto` = Chama a função padrão [_auto]
  /// - `SideMenuMode.open` = Chama a função [_open] que inicializa os menus sempre abertos
  /// - `SideMenuMode.compact` = Chama a função [_compact] que mantém os menus compactador quando a aplicação é iniciada 
  late SideMenuMode mode;
  ///[priority] defino a prioridade do menu no redimensionamento da largura
  ///- `SideMenuPriority.mode` = 
  ///- `SideMenuPriority.sizer` =
  late SideMenuPriority priority;
  late bool hasResizer;
  ///Largura atual
  late double currentWidth;
  ///largura do dispositivo
  late double deviceWidth;
  ///Largura mínima
  late double minWidth;
  ///Largura máxima
  late double maxWidth;

  double calculateWidthSize({
    required SideMenuMode mode,
    required bool hasResizer,
    required double minWidth,
    required double maxWidth,
    required double currentWidth,
    required double deviceWidth,
    required SideMenuPriority priority,
  }) {
    this.mode = mode;
    this.priority = priority;
    this.hasResizer = hasResizer;
    this.minWidth = minWidth;
    this.maxWidth = maxWidth;
    this.currentWidth = currentWidth;
    this.deviceWidth = deviceWidth;

    switch (mode) {
      case SideMenuMode.open:
        return _open();
      case SideMenuMode.compact:
        return _compact();
      case SideMenuMode.auto:
      default:
        return _auto();
    }
  }

  /// Essa função faz a seguinte verificação
  /// #### Lógica
  /// se `_isPossibleWidthChange` tiver um retorno true, ele envia o tamanho
  /// da largura atual do meu dispositivo pela variável `deviceWidth`, 
  /// a função isDesktop verifica se o valor de deviceWidth é >= a 950(constante de DeviceScreenType) 
  /// se for true retorna maxWidth 
  /// #### Caso contrário
  /// retorna minWidth
  /// #### E caso 
  /// `_isPossibleWidthChange` == false retorna `currentWidth`
  double _auto() {
    if (_isPossibleWidthChange()) {
      if (DeviceScreenType.isDesktop(width: deviceWidth)) {
        return maxWidth;
      } else {
        return minWidth;
      }
    }
    return currentWidth;
  }

 /// Essa função faz a seguinte verificação
 /// #### Lógica
 /// se `_isPossibleWidthChange` for true retorna `maxWidth`
 /// #### Caso contrário 
 /// retorna currentWidth
  double _open() {
    if (_isPossibleWidthChange()) {
      return maxWidth;
    }
    return currentWidth;
  }

/// Essa função faz a seguinte verificação
 /// #### Lógica
 /// se `_isPossibleWidthChange` for true retorna `minWidth`
 /// #### Caso contrário 
 /// retorna currentWidth
  double _compact() {
    if (_isPossibleWidthChange()) {
      return minWidth;
    }
    return currentWidth;
  }

  ///Essa função verifica se é possível a largura mudar
  /// #### Lógica
  /// Se `!hasResizer` for `false` ou `priority` for igual a `SideMenuPriority.mode`
  /// ou `currentWidth` == `Constants.zeroWidth` 
  /// #### Retorna: 
  ///   true
  /// #### Caso contrário
  /// retorna o booleano desse cara `_isCurrentWidthCustom`
  bool _isPossibleWidthChange() {
    if (!hasResizer ||
        priority == SideMenuPriority.mode ||
        currentWidth == Constants.zeroWidth) {
      return true;
    } else {
      return !_isCurrentWidthCustom();
    }
  }

  ///Verifica se a largura atual é personalizada
  ///#### Lógica 
  ///Se `currentWidth` for igual a `maxWidth` ou `currentWidth` for igual a `minWidth`
  ///#### Retorna 
  /// false
  ///#### Caso contrário 
  /// true
  bool _isCurrentWidthCustom() {
    if (currentWidth == maxWidth || currentWidth == minWidth) {
      return false;
    } else {
      return true;
    }
  }
}

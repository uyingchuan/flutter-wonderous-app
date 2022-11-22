// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:wonders/common_libs.dart';
export 'package:wonders/styles/colors.dart';

final $styles = AppStyle();

@immutable
class AppStyle {
  /// app 主题色
  final AppColors colors = AppColors();

  /// 文字样式
  late final _Text text = _Text();

  /// 内外边距
  late final _Insets insets = _Insets();

  /// 圆角半径
  late final _Corners corners = _Corners();
}

@immutable
class _Text {
  final Map<String, TextStyle> _titleFonts = {
    'en': const TextStyle(fontFamily: 'Tenor'),
  };

  final Map<String, TextStyle> _monoTitleFonts = {
    'en': const TextStyle(fontFamily: 'B612Mono'),
  };

  final Map<String, TextStyle> _quoteFonts = {
    'en': const TextStyle(fontFamily: 'Cinzel'),
    'zh': const TextStyle(fontFamily: 'MaShanZheng'),
  };

  final Map<String, TextStyle> _wonderTitleFonts = {
    'en': const TextStyle(fontFamily: 'Yeseva'),
  };

  final Map<String, TextStyle> _contentFonts = {
    'en': const TextStyle(fontFamily: 'Raleway', fontFeatures: [
      FontFeature.enable('dlig'),
      FontFeature.enable('kern'),
    ]),
  };

  TextStyle copy(TextStyle style, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
    return style.copyWith(
      fontSize: sizePx,
      height: heightPx != null ? (heightPx / sizePx) : style.height,
      letterSpacing: spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
      fontWeight: weight,
    );
  }
}

@immutable
class _Insets {
  late final double xxs = 4;
  late final double xs = 8;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
  late final double xxl = 56;
  late final double offset = 80;
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
}

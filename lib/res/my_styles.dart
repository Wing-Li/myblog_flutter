import 'package:flutter/material.dart';
import 'package:lylblog/utils/my_utils.dart';

import 'my_theme.dart';

class TextStyles {
  static TextStyle base({
    double size = 14,
    double? wordSpacing,
    double? heightSpacingMult,
    double? letterSpacing,
    Color? color,
    bool isBold = false,
    bool isFontWeightBold = false,
    bool isItalic = false,
    TextDecoration? textDecoration,
    String? fontFamily,
  }) =>
      TextStyle(
        height: heightSpacingMult == null ? 1.0 : heightSpacingMult,
        wordSpacing: wordSpacing == null ? 1.0 : wordSpacing,
        // 每个词之间的间距
        letterSpacing: letterSpacing == null ? 1.0 : letterSpacing,
        // 每一个字符之间的间距
        fontSize: size,
        color: color != null ? color : MyTheme.block,
        fontWeight: isFontWeightBold ? FontWeight.bold : FontWeight.normal,
        fontFamily: !MyUtils.isEmpty(fontFamily)
            ? fontFamily
            : isBold
                ? "Avenir-Bold"
                : "Avenir-Medium",
        decoration: textDecoration == null ? TextDecoration.none : textDecoration,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      );

  static TextStyle title(
    double size, {
    bool isFontWeightBold = true,
    Color color = MyTheme.white,
    String fontFamily = "Berg-Regular",
  }) =>
      base(
        size: size,
        color: color,
        isFontWeightBold: isFontWeightBold,
        fontFamily: fontFamily,
      );

  static TextStyle text(
    double size, {
    bool isBold = false,
    bool isItalic = false,
    Color color = MyTheme.text_white_block,
    double? letterSpacing,
    double? heightSpacingMult,
  }) =>
      base(
        size: size,
        color: color,
        isBold: isBold,
        isItalic: isItalic,
        letterSpacing: letterSpacing,
        heightSpacingMult: heightSpacingMult,
      );

  static TextStyle textWhite(
    double size, {
    bool isBold = false,
    bool isFontWeightBold = false,
    bool isItalic = false,
    TextDecoration? textDecoration,
    double? letterSpacing,
    double? heightSpacingMult,
  }) =>
      base(
        size: size,
        color: MyTheme.white,
        isBold: isBold,
        isFontWeightBold: isFontWeightBold,
        isItalic: isItalic,
        textDecoration: textDecoration,
        letterSpacing: letterSpacing,
        heightSpacingMult: heightSpacingMult,
      );

  static TextStyle textWhiteBold(
    double size, {
    bool isFontWeightBold = false,
    Color color = MyTheme.white,
    double? letterSpacing,
    double? heightSpacingMult,
  }) =>
      base(
        size: size,
        color: color,
        isBold: true,
        isFontWeightBold: isFontWeightBold,
        letterSpacing: letterSpacing,
        heightSpacingMult: heightSpacingMult,
      );

  static TextStyle textGray(double size, {bool isBold = false, TextDecoration? textDecoration}) => base(
        size: size,
        color: MyTheme.text_white_gray_light,
        isBold: isBold,
        textDecoration: textDecoration,
      );

  static TextStyle textGrayDeep(double size, {bool isBold = false}) => base(
        size: size,
        color: MyTheme.text_white_gray_deep,
        isBold: isBold,
      );

  static TextStyle textBlock(double size, {Color color = MyTheme.text_white_block, bool isItalic = false}) => base(
        size: size,
        color: color,
        isItalic: isItalic,
        isBold: false,
        isFontWeightBold: true,
      );

  static TextStyle textBold(double size, {Color color = MyTheme.block}) => base(
        size: size,
        color: MyTheme.block,
        isBold: true,
        isFontWeightBold: true,
      );
}

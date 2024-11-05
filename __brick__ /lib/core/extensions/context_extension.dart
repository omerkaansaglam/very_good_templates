import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double get heightWithoutSafeArea =>
      height - mediaQuery.padding.top - mediaQuery.padding.bottom;
  double get widthWithoutSafeArea =>
      width - mediaQuery.padding.left - mediaQuery.padding.right;
  double dynamicWidth(double val) => mediaQuery.size.width * val;
  double dynamicHeight(double val) => mediaQuery.size.height * val;

  double get statusBarHeight => mediaQuery.padding.top;
  double get bottomBarHeight => mediaQuery.padding.bottom;
  double get viewInsetsBottom => mediaQuery.viewInsets.bottom;
  bool get isKeyBoardOpen => viewInsetsBottom > 0;
  double get keyboardHeight => viewInsetsBottom;
}

extension GapExtension on double {
  Gap get gap => Gap(this);
  SliverGap get sliverGap => SliverGap(this);
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeManagerProvider =
    NotifierProvider<_ThemeManager, ThemeMode>(_ThemeManager.new);

class _ThemeManager extends Notifier<ThemeMode> {
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setTheme(ThemeMode themeMode) {
    state = themeMode;
  }

  @override
  ThemeMode build() {
    return ThemeMode.light;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

class MainBuild {
  MainBuild._();
  static Widget build(BuildContext context, Widget? child) {
    return SafeArea(
      top: false,
      bottom: Platform.isAndroid,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                child ?? const SizedBox.shrink(),
                // const GlobalOverlayWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

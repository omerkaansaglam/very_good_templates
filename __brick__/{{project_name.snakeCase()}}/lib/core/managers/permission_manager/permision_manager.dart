import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:{{project_name.snakeCase()}}/core/enums/permission_type.dart';
import 'package:{{project_name.snakeCase()}}/core/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionManager =
    AutoDisposeProvider<_PermissionManager>(_PermissionManager.new);

class _PermissionManager {
  final Ref ref;

  _PermissionManager(this.ref);

  /// Methods
  ///ATT Request For iOS
  Future<void> requestAppTrackingTransparencyForIOS() async {
    if (!Platform.isIOS) return;

    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;

    if (status != TrackingStatus.notDetermined) return;

    await AppTrackingTransparency.requestTrackingAuthorization();
  }

  Future<bool> checkMicrophonePermission() async {
    final status = await Permission.microphone.status;

    if (status.isPermanentlyDenied) {
      await openGoToSettingsPopup(PermissionType.microphone);

      return false;
    }

    if (!status.isGranted) {
      final result = await Permission.microphone.request();
      return result.isGranted;
    }

    return true;
  }

  Future<bool> checkCameraPermission() async {
    final status = await Permission.camera.status;

    if (status.isPermanentlyDenied) {
      await openGoToSettingsPopup(PermissionType.camera);

      return false;
    }

    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }

    return true;
  }

  Future<bool> checkGalleryPermission() async {
    final status = await Permission.photos.status;

    if (status.isPermanentlyDenied) {
      await openGoToSettingsPopup(PermissionType.gallery);

      return false;
    }

    if (!status.isGranted) {
      final result = await Permission.photos.request();
      return result.isGranted;
    }

    return true;
  }

  Future<dynamic> openGoToSettingsPopup(PermissionType permissionType) async {
    return await showDialog(
      context: ref.read(routerProvider).navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text('${permissionType.name} permission denied!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancel'.tr()),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: Text('go_to_settings'.tr()),
            ),
          ],
        );
      },
    );
  }
}

import 'dart:developer';
import 'dart:io';
import 'package:{{project_name.snakeCase()}}/core/managers/permission_manager/permision_manager.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class _MediaManager {
  _MediaManager(this.ref);

  Ref ref;
  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>?> pickImage({
    bool pickMultiImage = true,
    ImageSource? imageSource = ImageSource.gallery,
    int limit = 3,
  }) async {
    List<XFile>? imagesList;
    try {
      if (ImageSource.camera == imageSource) {
        final status =
            await ref.read(permissionManager).checkCameraPermission();
        if (!status) return null;
      } else {
        final status =
            await ref.read(permissionManager).checkGalleryPermission();
        if (!status) return null;
      }
      if (pickMultiImage) {
        imagesList = await _picker.pickMultiImage(
          limit: limit,
        );
      } else {
        final image =
            await _picker.pickImage(source: imageSource!, imageQuality: 75);
        if (image != null) {
          imagesList = [image];
        }
      }
      return imagesList;
    } catch (e) {
      return null;
    }
  }

  Future<Uint8List> convertXFileToImage(XFile xFile) async {
    return xFile.readAsBytes();
  }

  Future<File?> compressAndGetFile(
    XFile imageFile, {
    int maxDimension = 1024,
  }) async {
    try {
      final filePath = imageFile.path;

      final bytesImage = await convertXFileToImage(imageFile);
      final decodedImage = im.decodeImage(bytesImage);
      if (decodedImage == null) {
        log('Failed to decode image');
        return null;
      }

      if (decodedImage.width <= maxDimension &&
          decodedImage.height <= maxDimension) {
        return File(filePath);
      }

      final (width, height) = _calculateResizedDimensions(
        decodedImage.width,
        decodedImage.height,
        maxDimension,
      );

      final smallerImage = im.copyResize(
        decodedImage,
        width: width,
        height: height,
      );

      final compressedImage = File(filePath)
        ..writeAsBytesSync(im.encodePng(smallerImage));

      return compressedImage;
    } catch (e) {
      log('Image compression failed: $e');
      return null;
    }
  }

  (int width, int height) _calculateResizedDimensions(
    int originalWidth,
    int originalHeight,
    int maxDimension,
  ) {
    if (originalHeight > originalWidth) {
      final width = (maxDimension * originalWidth / originalHeight).round();
      return (width, maxDimension);
    } else {
      final height = (maxDimension * originalHeight / originalWidth).round();
      return (maxDimension, height);
    }
  }

  // Helper function to get image dimensions (width and height)
  Future<List<int>> getImageDimensions(XFile imageFile) async {
    try {
      final data = await imageFile.readAsBytes();
      final ui.Codec codec = await ui.instantiateImageCodec(data);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image image = frameInfo.image;

      return [image.height, image.width]; // Return the height and width
    } catch (e) {
      throw Exception('Image processing error $e');
    }
  }
}

final mediaManagerProvider = Provider(_MediaManager.new);

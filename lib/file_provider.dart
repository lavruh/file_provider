import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'android_file_provider.dart';
import 'file_picker_provider.dart';

abstract class IFileProvider {
  Future<File> selectFile({
    required BuildContext context,
    required String title,
    List<String>? allowedExtensions,
  });

  Future<Directory> selectDirectory({required String title});

  Future<bool> saveDataToFile({
    required Uint8List data,
    List<String>? allowedExtensions,
  });
}

class FileProvider {
  static IFileProvider getInstance() {
    if (Platform.isAndroid) return AndroidFileProvider();
    return PickerFileProvider();
  }
}

class FileProviderException implements Exception {
  final String message;
  FileProviderException(this.message);
}

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'file_provider.dart';

class PickerFileProvider implements IFileProvider {
  @override
  Future<File> selectFile({
    required BuildContext context,
    required String title,
    List<String>? allowedExtensions,
  }) async {
    try {
      final f = await FilePicker.platform.saveFile(
        dialogTitle: title,
        allowedExtensions: allowedExtensions,
        type: allowedExtensions == null ? FileType.any : FileType.custom,
      );
      if (f == null) throw FileProviderException('No file selected');
      final filePath = f;
      if (filePath.isEmpty) throw FileProviderException("Wrong file path");
      return File(filePath);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> saveDataToFile({
    required Uint8List data,
    List<String>? allowedExtensions,
  }) async {
    try {
      FilePicker.platform.saveFile(
        allowedExtensions: allowedExtensions,
        bytes: data,
      );
    } on Exception catch (_) {
      return false;
    }
    return true;
  }

  @override
  Future<Directory> selectDirectory({required String title}) async {
    final path = await FilePicker.platform.getDirectoryPath(dialogTitle: title);
    if (path == null) throw FileProviderException('No directory selected');
    final dir = Directory(path);
    if (dir.existsSync()) return dir;
    throw FileProviderException('Directory does not exist');
  }
}

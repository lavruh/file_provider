import 'dart:io';
import 'package:file_picker/file_picker.dart';
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
}

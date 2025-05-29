import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';

import 'file_provider.dart';

class AndroidFileProvider implements IFileProvider {
  @override
  Future<File> selectFile({
    required BuildContext context,
    required String title,
    List<String>? allowedExtensions,
  }) async {
    final d = await FilePicker.platform.getDirectoryPath(
      dialogTitle: "Select work directory",
    );
    if (d == null) throw FileProviderException('No directory selected');
    final dir = Directory(d);
    if (!dir.existsSync()) {
      throw FileProviderException('Directory does not exist');
    }
    if (context.mounted) {
      final f = await FilesystemPicker.open(
        title: title,
        context: context,
        rootDirectory: dir,
      );
      if (f == null) throw FileProviderException('No file selected');
      return File(f);
    }
    throw FileProviderException('Context is not mounted');
  }
}

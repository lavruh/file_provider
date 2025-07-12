import 'dart:typed_data';

import 'package:file_provider/file_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FilePickerExample(),
    );
  }
}

class FilePickerExample extends StatefulWidget {
  const FilePickerExample({super.key});
  @override
  State<FilePickerExample> createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {
  String filePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Selected file: $filePath'),
            TextButton(onPressed: _selectFile, child: Text("Select File")),
            TextButton(
              onPressed: _saveDataToFile,
              child: Text("Save data to File"),
            ),
            TextButton(
              onPressed: _selectDirectory,
              child: Text("Select Directory"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _selectFile() {
    final provider = FileProvider.getInstance();
    final f = provider.selectFile(
      context: context,
      title: 'Select file',
      allowedExtensions: [".txt"],
    );
    f.then((value) {
      setState(() {
        filePath = value.path;
      });
    });
  }

  void _saveDataToFile() {
    final provider = FileProvider.getInstance();

    final data = Uint8List.fromList("Hello world".codeUnits);

    provider.saveDataToFile(data: data, allowedExtensions: [".txt"]);
  }

  void _selectDirectory() async {
    final provider = FileProvider.getInstance();
    final dir = await provider.selectDirectory(title: "Select directory");
    filePath = dir.path;
    setState(() {});
  }
}

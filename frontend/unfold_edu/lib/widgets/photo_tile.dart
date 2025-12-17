import 'dart:typed_data';
import 'package:flutter/material.dart';

class PhotoTile extends StatelessWidget {
  final String filename;
  final Uint8List bytes;
  final String view;

  const PhotoTile({
    super.key,
    required this.filename,
    required this.bytes,
    required this.view,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.memory(bytes, width: 48, height: 48, fit: BoxFit.cover),
        title: Text(filename),
        subtitle: Text('View: $view'),
      ),
    );
  }
}

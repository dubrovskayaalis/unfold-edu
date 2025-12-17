import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/grpc_gateway.dart';
import '../widgets/dimension_input.dart';
import '../widgets/photo_tile.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _projectCtrl = TextEditingController(text: 'demo-project');
  final List<(String filename, Uint8List bytes, String view)> _photos = [];
  final List<(String name, double value)> _dimensions = [
    ('width_mm', 200.0),
    ('height_mm', 300.0),
  ];
  bool _loading = false;
  String? _resultJobId;
  String? _statusMsg;

  Future<void> _pickPhotos() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true,
    );
    if (res == null) return;
    setState(() {
      for (final f in res.files) {
        if (f.bytes == null) continue;
        _photos.add((f.name, f.bytes!, 'front'));
      }
    });
  }

  Future<void> _upload() async {
    final gateway = context.read<GrpcGateway>();
    setState(() {
      _loading = true;
      _statusMsg = null;
      _resultJobId = null;
    });
    try {
      final resp = await gateway.uploadPhotos(
        projectId: _projectCtrl.text.trim(),
        photos: _photos,
        dimensions: _dimensions,
      );
      setState(() {
        _resultJobId = resp.jobId.isNotEmpty ? resp.jobId : null;
        _statusMsg = resp.status;
      });
    } catch (e) {
      setState(() {
        _statusMsg = 'Upload failed: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload photos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _projectCtrl,
              decoration: const InputDecoration(
                labelText: 'Project ID',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text('Pick photos'),
                  onPressed: _pickPhotos,
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text('Upload'),
                  onPressed: _photos.isEmpty || _loading ? null : _upload,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  for (final p in _photos)
                    PhotoTile(filename: p.$1, bytes: p.$2, view: p.$3),
                  const SizedBox(height: 12),
                  DimensionInput(
                    dimensions: _dimensions,
                    onChanged: (list) => setState(() => _dimensions
                      ..clear()
                      ..addAll(list)),
                  ),
                ],
              ),
            ),
            if (_loading) const LinearProgressIndicator(),
            if (_statusMsg != null)
              Text(_statusMsg!, style: const TextStyle(color: Colors.black87)),
            if (_resultJobId != null)
              Text('Job ID: $_resultJobId',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

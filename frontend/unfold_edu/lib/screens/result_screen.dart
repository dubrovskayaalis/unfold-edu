import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/grpc_gateway.dart';
import '../proto/cnc.pb.dart' as cnc;
import '../widgets/artifact_card.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _jobCtrl = TextEditingController();
  List<cnc.ArtifactRef> _artifacts = [];
  String? _error;

  Future<void> _load() async {
    setState(() {
      _error = null;
      _artifacts = [];
    });
    try {
      final gateway = context.read<GrpcGateway>();
      final resp = await gateway.getArtifacts(_jobCtrl.text.trim());
      setState(() {
        _artifacts = resp.artifacts;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artifacts')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _jobCtrl,
              decoration: const InputDecoration(labelText: 'Job ID'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Load'),
              onPressed: _load,
            ),
            const SizedBox(height: 16),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                children: [
                  for (final a in _artifacts) ArtifactCard(artifact: a),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../proto/cnc.pb.dart' as cnc;

class ArtifactCard extends StatelessWidget {
  final cnc.ArtifactRef artifact;

  const ArtifactCard({super.key, required this.artifact});

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _openUrl(artifact.url),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(artifact.type, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                artifact.url,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:typed_data';
import 'package:grpc/grpc.dart';
import 'package:path/path.dart' as p;

import '../proto/cnc.pbgrpc.dart' as cnc;

class GrpcGateway {
  final String host;
  final int port;
  ClientChannel? _channel;
  cnc.GatewayClient? _client;

  GrpcGateway({
    this.host = '127.0.0.1',
    this.port = 50051,
  });

  Future<void> connect() async {
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        idleTimeout: Duration(minutes: 5),
      ),
    );
    _client = cnc.GatewayClient(_channel!);
  }

  Future<void> shutdown() async {
    await _channel?.shutdown();
    _channel = null;
    _client = null;
  }

  Future<cnc.UploadPhotosResponse> uploadPhotos({
    required String projectId,
    required List<(String filename, Uint8List bytes, String view)> photos,
    required List<(String name, double value)> dimensions,
  }) async {
    if (_client == null) {
      await connect();
    }

    final req = cnc.UploadPhotosRequest()
      ..projectId = projectId
      ..photos.addAll(photos.map((ph) {
        final msg = cnc.Photo()
          ..filename = p.basename(ph.$1)
          ..data = ph.$2
          ..view = ph.$3;
        return msg;
      }))
      ..dimensions.addAll(dimensions.map((d) {
        final msg = cnc.Dimension()
          ..name = d.$1
          ..value = d.$2;
        return msg;
      }));

    return _client!.uploadPhotos(req);
  }

  ResponseFuture<cnc.UploadPhotosResponse> modelToUnfold(Stream<List<int>> chunks) {
    if (_client == null) {
      throw StateError('Call connect() before streaming');
    }
    final stream = chunks.map((c) => cnc.ModelChunk()..data = Uint8List.fromList(c));
    return _client!.modelToUnfold(stream);
  }

  Future<cnc.GetArtifactsResponse> getArtifacts(String jobId) async {
    if (_client == null) {
      await connect();
    }
    final req = cnc.GetArtifactsRequest()..jobId = jobId;
    return _client!.getArtifacts(req);
  }
}

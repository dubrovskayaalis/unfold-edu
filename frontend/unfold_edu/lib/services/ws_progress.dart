import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsProgress {
  final Uri uri;
  WebSocketChannel? _channel;

  WsProgress(String url) : uri = Uri.parse(url);

  void connect() {
    _channel = WebSocketChannel.connect(uri);
  }

  Stream<String> messages() {
    if (_channel == null) {
      throw StateError('Call connect() before subscribing');
    }
    return _channel!.stream.map((event) => event.toString());
  }

  void send(String msg) {
    _channel?.sink.add(msg);
  }

  Future<void> close() async {
    await _channel?.sink.close();
    _channel = null;
  }
}

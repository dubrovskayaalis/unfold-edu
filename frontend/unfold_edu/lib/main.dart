import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/grpc_gateway.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const UnfoldEduApp());
}

class UnfoldEduApp extends StatelessWidget {
  const UnfoldEduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => GrpcGateway()),
      ],
      child: MaterialApp(
        title: 'Unfold EDU',
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

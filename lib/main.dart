import 'package:flutter_escola/shared/fixed_string.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'global_module.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Core());
}

class Core extends StatelessWidget {
  const Core({super.key});

  static final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ModularApp(
      module: GlobalModule(),
      child: MaterialApp.router(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        title: FixedString.appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFFF6D00),
              background: const Color(0xFFF8F8F8)),
          useMaterial3: true,
        ),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}

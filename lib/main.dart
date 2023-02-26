import 'package:easy_localization/easy_localization.dart';
import 'package:flink/service/core/sqlite_service.dart';
import 'package:flink/utility/logger_facade.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) LoggerFacade.initialize();
  await EasyLocalization.ensureInitialized();
  await SqliteService.instance.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      path: 'assets/i18n',
      fallbackLocale: const Locale('en', 'US'),
      child: const FlinkApp(),
    ),
  );
}

class FlinkApp extends StatelessWidget {
  const FlinkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flink'),
          centerTitle: true,
        ),
      ),
    );
  }
}

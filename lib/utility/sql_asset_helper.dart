import 'dart:convert';

import 'package:flutter/services.dart';

/// Meant to be used as interface class to anything related to `assets/sql/*`
class SqlAssetHelper {

  /// Load all `*.sql` file content located in `assets/sql/*.sql` into a Map.
  ///
  /// Each entry of a map should represent the content of one SQL script.
  static Future<Map<int, String>> getSQLScripts() async {
    final String manifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = jsonDecode(manifest);

    final List<String> sqlScriptPaths = manifestMap.keys
        .where((String key) => key.contains('sql/'))
        .where((String key) => key.contains('.sql'))
        .toList();

    final Map<int, String> sqlScripts = {};
    int version = 1;
    for (String path in sqlScriptPaths) {
      final String sqlFileContent = await rootBundle.loadString(path);
      sqlScripts[version] = sqlFileContent;
      version++;
    }

    return sqlScripts;
  }
}
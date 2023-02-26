import 'package:flink/utility/logger_facade.dart';
import 'package:flink/utility/sql_asset_helper.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static final LoggerFacade _log = LoggerFacade(SqliteService);
  Database? _database;

  /// An [SqliteService] instance
  static SqliteService? _instance;

  /// Private constructor
  SqliteService._();

  /// Expose or create an [_instance]
  static SqliteService get instance => _instance ??= SqliteService._();

  /// Initialize [_database] and create tables
  Future<void> initialize() async {
    final Map<int, String> sqlScripts = await SqlAssetHelper.getSQLScripts();
    final scriptAmount = sqlScripts.length;
    final String appDocDirectory = await getDatabasesPath();
    final String databasePath = '$appDocDirectory/flink-app.db';
    _database = await openDatabase(
      databasePath,
      version: scriptAmount,
      onCreate: (db, version) async {
        _log.info('Initializing table structure...');
        for (int i = 1; i <= scriptAmount; i++) {
          List<String> scripts = sqlScripts[i]!.split(';');
          scripts.removeWhere((element) => element == '\r\n');
          for (var element in scripts) {
            await db.execute(element);
          }
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        _log.info('Initial table structure recognized. Applying migrations...');
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          final List<String> scripts = sqlScripts[i]!.split(';');
          scripts.removeWhere((element) => element == '\r\n');
          for (var element in scripts) {
            await db.execute(element);
          }
        }
      },
    );
  }

  /// Expose [_database]
  Database get database {
    if (_database == null) {
      throw Exception('Database is not created yet');
    }
    return _database as Database;
  }
}

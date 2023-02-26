import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

/// A Facade around the logging package to keep the dependency in this class only
///
/// Also with this you can just instantiate the logger like:
/// ```
/// final LoggerFacade _log = LoggerFacade(MyType);
/// ```
///
/// instead of:
/// ```
/// final Logger _log = Logger((MyType).toString());
/// ```
class LoggerFacade {
  /// A private [Logger] instance
  late final Logger _log;

  /// The [Type] in which we wish to log
  final Type classType;

  /// Constructor initializes the logger dependency
  LoggerFacade(this.classType) {
    _log = Logger(classType.toString());
  }

  static void initialize() {
    // Configure logger
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      debugPrint('${record.level.name}: ${record.time}: '
          '${record.loggerName}: '
          '${record.message}');
    });
  }

  /// Wrappers around dependency logging methods
  void info(String message) => _log.info(message);

  void severe(String message) => _log.severe(message);
}

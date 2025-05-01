import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Logger {
  static final StringBuffer _loggingBuffer = StringBuffer('');
  static bool _debugMode = false;
  static LogLevel _logLevel = LogLevel.info;

  static final DateFormat format = DateFormat.Hms();

  static set logLevel(LogLevel newLogLevel) {
    _logLevel = newLogLevel;
  }

  static set setDebugMode(bool mode) {
    _debugMode = mode;
    if (!mode) {
      _loggingBuffer.clear();
    }
  }

  static void verbose(dynamic msg) {
    if (_logVerbose) {
      debugPrint("\x1B[35m$getTimeStamp V: $msg");
      if (_debugMode) {
        _loggingBuffer.writeln("$getTimeStamp V: $msg");
      }
    }
  }

  static void debug(dynamic msg) {
    if (_logDebug) {
      debugPrint("\x1B[36m$getTimeStamp D: $msg");
      if (_debugMode) {
        _loggingBuffer.writeln("$getTimeStamp D: $msg");
      }
    }
  }

  static void info(dynamic msg) {
    if (_logInfo) {
      debugPrint("$getTimeStamp I: $msg");
      if (_debugMode) {
        _loggingBuffer.writeln("$getTimeStamp I: $msg");
      }
    }
  }

  static void warning(dynamic msg) {
    if (_logWarning) {
      debugPrint("\x1B[33m$getTimeStamp W: $msg");
      if (_debugMode) {
        _loggingBuffer.writeln("$getTimeStamp W: $msg");
      }
    }
  }

  static void error(dynamic msg) {
    if (_logError) {
      debugPrint("\x1B[31m$getTimeStamp E: $msg");
      if (_debugMode) {
        _loggingBuffer.writeln("$getTimeStamp E: $msg");
      }
    }
  }

  static bool get _logVerbose {
    return _logLevel == LogLevel.verbose;
  }

  static bool get _logDebug {
    return _logLevel == LogLevel.verbose || _logLevel == LogLevel.debug;
  }

  static bool get _logInfo {
    return _logLevel == LogLevel.verbose ||
        _logLevel == LogLevel.debug ||
        _logLevel == LogLevel.info;
  }

  static bool get _logWarning {
    return _logLevel == LogLevel.verbose ||
        _logLevel == LogLevel.debug ||
        _logLevel == LogLevel.info ||
        _logLevel == LogLevel.warning;
  }

  static bool get _logError {
    return _logLevel == LogLevel.verbose ||
        _logLevel == LogLevel.debug ||
        _logLevel == LogLevel.info ||
        _logLevel == LogLevel.warning ||
        _logLevel == LogLevel.error;
  }

  static bool get getDebugMode {
    return _debugMode;
  }

  static String get getLoggingBuffer {
    return _loggingBuffer.toString();
  }

  static String get getTimeStamp {
    return "${format.format(DateTime.now())}-${DateTime.now().millisecond.toString().padLeft(3, "0")}";
  }
}

enum LogLevel { verbose, debug, info, warning, error }

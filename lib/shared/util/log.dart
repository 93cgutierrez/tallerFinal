import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../config/networking/utils/parameters_api_util.dart';

class Log {
  static Logger? logger;
  static String separator = "=>";


  static instance() {
    if (logger != null) return logger!;
    logger = Logger(
      printer: PrettyPrinter(
          methodCount: 6,
          // Number of method calls to be displayed
          errorMethodCount: 8,
          // Number of method calls if stacktrace is provided
          lineLength: 1000,
          // Width of the output
          colors: true,
          // Colorful log messages
          printEmojis: true,
          // Print an emoji for each log message
          printTime: false // Should each log print contain a timestamp
          ),
    );
  }

  //printD
  static void printD(String tag, String message) {
    //if (kDebugMode) {
    debugPrint('$tag $separator $message');
    //}
  }

  //d
  static void d(String tag, String message) {
    printD(tag, message);
    instance();
    String logMessage = '(${ParametersApiUtil.appName}) [$tag] $separator $message';
    logger?.d(logMessage);
  }

  //wtf
  static void wtf(String tag, String message) {
    printD(tag, message);
    instance();
    String logMessage = '(${ParametersApiUtil.appName}) [$tag] $separator $message';
    logger?.wtf(logMessage);
  }

  //w
  static void w(String tag, String message) {
    printD(tag, message);
    instance();
    String logMessage = '(${ParametersApiUtil.appName}) [$tag] $separator $message';
    logger?.w(logMessage);
  }

  //i
  static void i(String tag, String message) {
    printD(tag, message);
    instance();
    String logMessage = '(${ParametersApiUtil.appName}) [$tag] $separator $message';
    logger?.i(logMessage);
  }

  //v
  static void v(String tag, String message) {
    printD(tag, message);
    instance();
    String logMessage = '(${ParametersApiUtil.appName}) [$tag] $separator $message';
    logger?.v(logMessage);
  }

  //e
  static void e(String tag, String message) {
    printD(tag, message);
    instance();
    String logMessage = '(${ParametersApiUtil.appName}) [$tag] $separator $message';
    logger?.v(logMessage);
  }
}

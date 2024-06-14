// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:taller_final/config/networking/utils/parameters_api_util.dart';

import '../../shared/util/log.dart';
import 'model/api_failure.dart';


/// An enum that holds names for our custom exceptions.
enum ExceptionType {
  /// The exception for an expired bearer token.
  TokenExpiredException,

  /// The exception for a prematurely cancelled request.
  CancelException,

  /// The exception for a failed connection attempt.
  ConnectTimeoutException,

  /// The exception for failing to send a request.
  SendTimeoutException,

  /// The exception for failing to receive a response.
  ReceiveTimeoutException,

  /// The exception for no internet connectivity.
  SocketException,

  /// A better name for the socket exception.
  FetchDataException,

  /// The exception for an incorrect parameter in a request/response.
  FormatException,

  /// The exception for an unknown type of failure.
  UnrecognizedException,

  /// The exception for an unknown exception from the api.
  ApiException,

  /// The exception for any parsing failure encountered during
  /// serialization/deserialization of a request.
  SerializationException,
  connectionErrorException,
  badCertificateException,
}

//TODO: CG 20230624 PENDING BACK KIND OF EXCEPTIONS
class CustomException implements Exception {
  final String name, message;
  final String? code;
  final int? statusCode;
  final ExceptionType exceptionType;
  final ApiFailure? apiFailure;

  CustomException({
    this.code,
    int? statusCode,
    required this.message,
    this.exceptionType = ExceptionType.ApiException,
    this.apiFailure,
  })  : statusCode = statusCode ?? 0,
        name = exceptionType.name;

  factory CustomException.fromDioException(Exception error) {
    const String tag = "CustomException";
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            return CustomException(
              exceptionType: ExceptionType.CancelException,
              statusCode: error.response?.statusCode,
              message: 'Request cancelled prematurely',
            );
          case DioExceptionType.connectionTimeout:
            return CustomException(
              exceptionType: ExceptionType.ConnectTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Connection not established',
            );
          case DioExceptionType.sendTimeout:
            return CustomException(
              exceptionType: ExceptionType.SendTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to send',
            );
          case DioExceptionType.receiveTimeout:
            return CustomException(
              exceptionType: ExceptionType.ReceiveTimeoutException,
              statusCode: error.response?.statusCode,
              message: 'Failed to receive',
            );
          case DioExceptionType.badResponse:
          case DioExceptionType.unknown:
            if (error.message!.contains(ExceptionType.SocketException.name)) {
              return CustomException(
                exceptionType: ExceptionType.FetchDataException,
                statusCode: error.response?.statusCode,
                message: ParametersApiUtil.networkErrorMessage,
              );
            }

            if (error.response?.data != null) {
              dynamic responseData = error.response?.data;
              int? statusCode = error.response?.statusCode;
              String statusMessage =
                  error.response?.statusMessage ?? ParametersApiUtil.empty;

              //TODO YP 20240323 replace by correct response from backend
              String defaultMessage =
                  ParametersApiUtil.defaultMessageCustomException;
              int defaultCodeValidate = ParametersApiUtil.defaultCodeValidate;
              String defaultStatusErrorCode =
                  ParametersApiUtil.defaultStatusError;
              String defaultErrorCode = ParametersApiUtil.defaultErrorCode;

              String? message;
              dynamic codeValidate = defaultCodeValidate; //this could be int or String
              String? statusErrorCode = defaultStatusErrorCode;
              String? errorCode = defaultErrorCode;
              try {
                if (responseData != null && responseData is Map) {
                  message = responseData['data']?['message'];
                  codeValidate =
                      responseData['data']?['code'] ?? defaultCodeValidate;
                  statusErrorCode =
                      responseData['data']?['status']?.toString() ??
                          ParametersApiUtil.empty;
                  errorCode = responseData['data']?['errorCode'].toString() ??
                      ParametersApiUtil.empty;

                  if (error.response?.data['result'] != null) {
                    statusMessage = responseData['statusDescription'];
                    message = responseData['result']?['message'];
                    codeValidate = responseData['result']?['codeValidate'] ??
                        defaultCodeValidate;
                    errorCode = responseData['result']?['internalCode'];
                  }
                } else if (responseData != null && responseData is String) {
                  message = responseData;
                  codeValidate = defaultCodeValidate;
                  statusErrorCode = defaultStatusErrorCode;
                  errorCode = defaultErrorCode;
                }

                //TODO YP 20240216 Replace when backend fix code types
                if (codeValidate.runtimeType == String) {
                  codeValidate = int.tryParse(codeValidate.toString()) ??
                      defaultCodeValidate;
                }
              } catch (e) {
                Log.e(tag, 'fromDioException Exception: $e');
              }

              return CustomException(
                message: statusMessage,
                statusCode: statusCode,
                apiFailure: ApiFailure(
                  statusCode: codeValidate ?? defaultCodeValidate,
                  statusMessage: message ?? defaultMessage,
                  statusDescription: statusErrorCode ?? defaultErrorCode,
                ),
              );
            } else if (error.response?.data[ParametersApiUtil.headersKey] ==
                null) {
              return CustomException(
                exceptionType: ExceptionType.UnrecognizedException,
                statusCode: error.response?.statusCode,
                message: error.response?.statusMessage ??
                    ParametersApiUtil.unknownMessage,
              );
            } else {
              return CustomException(
                exceptionType: ExceptionType.UnrecognizedException,
                statusCode: error.response?.statusCode,
                message: error.response?.statusMessage ??
                    ParametersApiUtil.unknownMessage,
              );
            }
          case DioExceptionType.badCertificate:
            return CustomException(
              exceptionType: ExceptionType.badCertificateException,
              message: 'Bad certificate detected',
            );
          case DioExceptionType.connectionError:
            return CustomException(
              exceptionType: ExceptionType.connectionErrorException,
              message: 'Connection error occurred',
            );
          default:
            return CustomException(
              exceptionType: ExceptionType.UnrecognizedException,
              message: ParametersApiUtil.unknownError,
            );
        }
      } else {
        return CustomException(
          exceptionType: ExceptionType.UnrecognizedException,
          message: ParametersApiUtil.unknownError,
        );
      }
    } on FormatException catch (e) {
      return CustomException(
        exceptionType: ExceptionType.FormatException,
        message: e.message,
      );
    } on Exception catch (_) {
      return CustomException(
        exceptionType: ExceptionType.UnrecognizedException,
        message: ParametersApiUtil.unknownError,
      );
    } catch (e) {
      return CustomException(
        exceptionType: ExceptionType.UnrecognizedException,
        message: e.toString(),
      );
    }
  }

  factory CustomException.fromParsingException(Exception error) {
    // TODO(arafaysaleem): add logging to print stack trace
    debugPrint('$error');
    return CustomException(
      exceptionType: ExceptionType.SerializationException,
      message: ParametersApiUtil.parserError,
    );
  }

  @override
  String toString() {
    return 'CustomException{\n'
        'name: ${exceptionType.name},'
        'message: $message,'
        'code: $code,'
        'statusCode: $statusCode,'
        'apiFailure: ${apiFailure.toString()}'
        '}';
  }
}

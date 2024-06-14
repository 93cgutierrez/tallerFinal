import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:taller_final/config/networking/utils/parameters_api_util.dart';

import '../../shared/util/log.dart';
import '../constant/api_endpoint.dart';
import 'api_interface.dart';
import 'custom_exception.dart';

class ApiClient extends DioForNative implements ApiInterface {
  final String _tag = 'ApiClient';

  String baseUrl;

  final Dio _dio = Dio();
  final String _token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGNiNzlhMTFlN2MzZWUwZGUwZDZiNmRkODUyOGVlYSIsInN1YiI6IjVlNjgzYTQxNTVjOTI2MDAxNTYzYWExNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RdaQl-vO8aP6y3-FLn3p3yF2cmAK-q4jbbzYnNv09Y4';

  //TODO: CG 20230622 VALIDATE LIMIT ATTEMPTS
  static const int attempts = 3;
  static int counterAttempts = 0;

  //seconds
  static const int timeout = 60;

  //flag that enables the inclusion of the session token in the request header
  final String _authorizationKey = 'Authorization';
  final String _contentTypeKey = 'ContentType';
  final String _contentTypeJsonValue = 'application/json';
  final String _appKey = 'app';
  final String _platformKey = 'platform';
  final String _versionKey = 'version';
  final String _bearerValue = 'Bearer';
  final String _tokenKey = 'token';
  final String _refreshTokenKey = 'refreshToken';
  String _refreshToken = '';

  ApiClient._internal(this.baseUrl);

  factory ApiClient({String? baseUrl}) {
    return ApiClient._internal(baseUrl ?? ApiEndpoint.baseUrl);
  }

  Dio _getApiClient() {
    //basic configuration
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout =
        const Duration(milliseconds: timeout * 1000); //60sg
    _dio.options.receiveTimeout =
        const Duration(milliseconds: timeout * 1000); //60sg

    _dio.interceptors.clear();

    //LOGGGER http
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      logPrint: (Object object) {
        if (kDebugMode) {
          String logMessage = "okHttp: ${object.toString()} ";
          Log.printD(_tag, logMessage);
        }
      },
    ));

/*    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      logPrint: (Object object) {
        if (kDebugMode) {
          Log.d(tag, "okHttp: ${object.toString()} ");
        }
      },
    ));*/

    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      //OPTIONAL HEADERS
      //Handler for session token
      if (options.extra[ParametersApiUtil.requiresAuthToken] == true) {
        Log.i(_tag, 'Current token: $_token');
        options.headers[_authorizationKey] = '$_bearerValue $_token';
        //TODO: CG 20230622 remove extra flag
        options.extra.remove(ParametersApiUtil.requiresAuthToken);
      }

      //MANDATORY HEADERS
      if (options.headers[_contentTypeKey] == null) {
        options.headers[_contentTypeKey] = _contentTypeJsonValue;
      }
      //print headers
      if (kDebugMode) {
        Log.i(_tag, 'okHttp: HEADERS: ${options.headers.toString()}');
      }
      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.resolve(response);
    }, onError: (DioException error, ErrorInterceptorHandler handler) async {
      if (kDebugMode) {
        Log.d(_tag, "counter: $counterAttempts");
      }
      return handler.next(error);
    }));
    return _dio;
  }

  /// An implementation of the base method for requesting of data [GET]
  /// from the [endpoint].
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  ///
  /// return [response] with the data of the response, client handles as needed.
  @override
  Future<Response<dynamic>> getData({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  }) async {
    try {
      // Items of table as json
      // Entire map of response
      return await _getApiClient().get(
        endpoint,
        options: Options(
          extra: <String, Object?>{
            ParametersApiUtil.requiresAuthToken: requiresAuthToken,
          },
        ),
        queryParameters: queryParams,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    } catch (ex) {
      throw Exception('Unknown exception: $ex');
    }
  }

  /// An implementation of the base method [POST] at the [endpoint].
  ///
  /// The [body] contains body for the request.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  ///
  /// return [response] with the data of the response, client handles as needed.
  @override
  Future<Response<dynamic>> postData({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  }) async {
    try {
      return (await _getApiClient().post(
        endpoint,
        data: body,
        options: Options(
          headers: headers,
          extra: <String, Object?>{
            ParametersApiUtil.requiresAuthToken: requiresAuthToken,
          },
        ),
        queryParameters: queryParams,
        cancelToken: cancelToken,
      ));
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    } catch (ex) {
      throw Exception('Unknown exception: $ex');
    }
  }

  /// An implementation of the base method [PATH]
  /// at the [endpoint].
  ///
  /// The [body] contains body for the request.
  ///
  ///  [queryParams] holds any query parameters for the request.
  ///
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  ///
  /// return [response] with the data of the response, client handles as needed.
  @override
  Future<Response<dynamic>> pathData({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  }) async {
    try {
      // Entire map of response
      // Items of table as json
      return (await _getApiClient().patch(
        endpoint,
        data: body,
        options: Options(
          extra: <String, Object?>{
            ParametersApiUtil.requiresAuthToken: requiresAuthToken,
          },
        ),
        queryParameters: queryParams,
        cancelToken: cancelToken,
      ));
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    } catch (ex) {
      throw Exception('Unknown exception: $ex');
    }
  }

  /// An implementation of the base method [DELETE]
  /// at the [endpoint].
  ///
  /// The [data] contains body for the request.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor].
  /// The default value is `true`.
  ///
  /// return [response] with the data of the response, client handles as needed.
  @override
  Future<Response<dynamic>> deleteData({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  }) async {
    try {
      // Entire map of response
      return (await _getApiClient().delete(
        endpoint,
        data: body,
        options: Options(
          extra: <String, Object?>{
            ParametersApiUtil.requiresAuthToken: requiresAuthToken,
          },
        ),
        queryParameters: queryParams,
        cancelToken: cancelToken,
      ));
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    } catch (ex) {
      throw Exception('Unknown exception: $ex');
    }
  }
}

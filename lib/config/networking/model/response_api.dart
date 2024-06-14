import 'package:taller_final/config/networking/model/state_api_enum.dart';

class ResponseApi {
  int statusCode;
  StateApi stateApi = StateApi.idle;
  Exception? error;
  dynamic data;

  ResponseApi(
      {this.statusCode = 0, required this.stateApi, this.error, this.data});

  ResponseApi copyWith(
      {int? statusCode, StateApi? stateApi, Exception? error, dynamic data}) {
    return ResponseApi(
        statusCode: statusCode ?? this.statusCode,
        stateApi: stateApi ?? this.stateApi,
        error: error ?? this.error,
        data: data ?? this.data);
  }
}

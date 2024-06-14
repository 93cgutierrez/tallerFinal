class ApiResult<T> {
  final T? data;
  final String? error;
  final String? internalCode;

  ApiResult({this.data, this.error, this.internalCode});
}

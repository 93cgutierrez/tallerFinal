
class ApiFailure {
  final int? statusCode;
  final String? statusMessage;
  final String? statusDescription;

  ApiFailure({
    this.statusCode,
    this.statusMessage,
    this.statusDescription,
  });

  @override
  String toString() {
    return 'ApiFailure('
        'statusCode: $statusCode, '
        'statusMessage: $statusMessage, '
        'statusDescription: $statusDescription, '
        ')';
  }
}

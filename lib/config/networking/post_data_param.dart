class PostDataParams {
  final String baseUrl;
  final String endpoint;
  final Map<String, dynamic> body;
  final Map<String, String> headers;

  PostDataParams({
    required this.baseUrl,
    required this.endpoint,
    required this.body,
    required this.headers,
  });

  @override
  toString(){
    return
      'baseUrl : ${baseUrl}endpoint : ${endpoint}body : ${body}headers : ${headers}';
  }
}
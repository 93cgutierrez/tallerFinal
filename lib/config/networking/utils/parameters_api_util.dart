

class ParametersApiUtil {
  static String baseUrl = 'https://api.themoviedb.org';
  static String baseUrlImage = 'https://image.tmdb.org/t/p/w500/';

  static int ok = 200;

  //code 401
  static const int unauthorized = 401;

  static const int delayRequests = 1; //seconds

  static var appName = 'Todo sobre series';

  static var requiresAuthToken = 'requiresAuthToken';

  static var headersKey = 'headers';

  static var bodyKey = 'body';

  static var errorKey = 'error';

  static var messageKey = 'message';

  static var codeKey = 'code';

  static var unknownError = 'Error unrecognized';
  static var unknownMessage = 'Unknown';

  static var parserError =
      'Failed to parse network response to model or vice versa';

  static var userName = 'User Name';

  static String defaultMessageCustomException = 'Lo sentimos, ha ocurrido un error. Intente de nuevo más tarde.';

  static int defaultCodeValidate = 10;

  static String defaultStatusError = '';

  static String defaultErrorCode = '';

  static String networkErrorMessage = 'No internet connectivity';

  static String empty = '';
}

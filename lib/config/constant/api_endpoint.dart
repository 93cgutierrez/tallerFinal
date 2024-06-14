import 'package:flutter/material.dart';
import 'package:taller_final/config/networking/utils/parameters_api_util.dart';

/// A utility class for getting paths for API endpoints.
/// This class has no constructor and all methods are `static`.
@immutable
class ApiEndpoint {
  const ApiEndpoint._();

  /// The base url of our REST API, to which all the requests will be sent.
  /// It is supplied at the time of building the apk or running the app:
  /// ```
  /// flutter build apk --debug --dart-define=BASE_URL=www.some_url.com
  /// ```
  /// OR
  /// ```
  /// flutter run --dart-define=BASE_URL=www.some_url.com
  /// ```
  static String baseUrl = ParametersApiUtil.baseUrl;

  /// Returns the path for an authentication [endpoint].

  static String auth(
      {required AuthEndpoint endpoint, VersionApi versionApi = VersionApi.v3}) {
    const path = '/tv';
    String version = versionApi.value;
    switch (endpoint) {
      case AuthEndpoint.login:
        return '$version/$path/auth/login';
      case AuthEndpoint.refreshToken:
        return '$version/$path/auth/login';
    }
  }

  static String tv({
    required TvEndpoint endpoint,
    VersionApi versionApi = VersionApi.v3,
    int? seriesId,
    int? seasonNumber,
  }) {
    const path = '/tv';
    String version = versionApi.value;
    switch (endpoint) {
      case TvEndpoint.search:
        return '$version/search/$path';
      case TvEndpoint.topRated:
        return '$version/$path/top_rated';
      case TvEndpoint.details:
        {
          assert(
              seriesId != null, 'seriesId is required for details for series');
          return '$version/$path/$seriesId';
        }

      case TvEndpoint.detailsTvSeason:
        {
          assert(
              seriesId != null, 'seriesId is required for details for season');
          assert(seasonNumber != null,
              'seasonNumber is required for details for season');
          return '$version/$path/$seriesId/season/$seasonNumber';
        }
    }
  }
}

//versionApi
enum VersionApi {
  v1('1'),
  v2('2'),
  v3('3');

  final String value;

  const VersionApi(this.value);
}

/// A collection of endpoints used for authentication purposes.
enum AuthEndpoint { login, refreshToken }

enum TvEndpoint { search, topRated, details, detailsTvSeason }

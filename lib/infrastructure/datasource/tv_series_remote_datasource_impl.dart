import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:taller_final/config/networking/model/api_failure.dart';

import 'package:taller_final/domain/entity/tv_series_details_entity.dart';

import 'package:taller_final/domain/entity/tv_series_entity.dart';

import 'package:taller_final/domain/entity/tv_series_season_details_entity.dart';
import 'package:taller_final/infrastructure/model/response/tv_season_details_response.dart';
import 'package:taller_final/infrastructure/model/response/tv_series_details_response.dart';

import '../../config/constant/api_endpoint.dart';
import '../../config/networking/api_client.dart';
import '../../config/networking/custom_exception.dart';
import '../../domain/datasource/tv_series_datasource.dart';
import '../model/response/tv_top_rated_response.dart';

class TvSeriesRemoteDatasourceImpl extends TvSeriesDatasource {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Either<ApiFailure?, List<TvSeriesEntity>>>
      getTopRatedTvSeries() async {
    try {
      final Response<dynamic> response = await _apiClient.getData(
          endpoint: ApiEndpoint.tv(endpoint: TvEndpoint.topRated));
      return Right(TvTopRatedResponse.fromMapToTvSeriesEntity(response.data));
    } on CustomException catch (customException) {
      if (customException.exceptionType == ExceptionType.ApiException) {
        return Left(customException.apiFailure);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Either<ApiFailure?, TvSeriesDetailsEntity>> getTvSeriesDetails(
      int seriesId) async {
    try {
      final Response<dynamic> response = await _apiClient.getData(
        endpoint: ApiEndpoint.tv(
          endpoint: TvEndpoint.details,
          seriesId: seriesId,
        ),
      );
      return Right(TvSeriesDetailsResponse.fromMapToTvSeriesDetailsEntity(response.data));
    } on CustomException catch (customException) {
      if (customException.exceptionType == ExceptionType.ApiException) {
        return Left(customException.apiFailure);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Either<ApiFailure?, TvSeriesSeasonDetailsEntity>>
      getTvSeriesSeasonDetails(int seriesId, int seasonNumber) async {
    try {
      final Response<dynamic> response = await _apiClient.getData(
        endpoint: ApiEndpoint.tv(
          endpoint: TvEndpoint.detailsTvSeason,
          seriesId: seriesId,
          seasonNumber: seasonNumber,
        ),
      );
      return Right(TvSeasonDetailsResponse.fromMapToTvSeriesSeasonDetailsEntity(response.data));
    } on CustomException catch (customException) {
      if (customException.exceptionType == ExceptionType.ApiException) {
        return Left(customException.apiFailure);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Either<ApiFailure?, List<TvSeriesEntity>>> searchTvSeries(
      String query) async {
    try {
      final Response<dynamic> response = await _apiClient.getData(
        endpoint: ApiEndpoint.tv(endpoint: TvEndpoint.search),
        queryParams: {'query': query},
      );
      return Right(TvTopRatedResponse.fromMapToTvSeriesEntity(response.data));
    } on CustomException catch (customException) {
      if (customException.exceptionType == ExceptionType.ApiException) {
        return Left(customException.apiFailure);
      } else {
        rethrow;
      }
    }
  }
}

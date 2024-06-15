import 'package:dartz/dartz.dart';

import '../../config/networking/model/api_failure.dart';
import '../entity/tv_series_details_entity.dart';
import '../entity/tv_series_entity.dart';
import '../entity/tv_series_season_details_entity.dart';

abstract class TvSeriesDatasource {
  Future<Either<ApiFailure?, List<TvSeriesEntity>>> searchTvSeries(
      String query);

  Future<Either<ApiFailure?, List<TvSeriesEntity>>> getTopRatedTvSeries();

  Future<Either<ApiFailure?, TvSeriesDetailsEntity>> getTvSeriesDetails(
      int seriesId);

  Future<Either<ApiFailure?, TvSeriesSeasonDetailsEntity>>
      getTvSeriesSeasonDetails(int seriesId, int seasonNumber);
}

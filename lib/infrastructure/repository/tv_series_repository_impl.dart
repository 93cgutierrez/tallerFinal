import 'package:dartz/dartz.dart';
import 'package:taller_final/config/networking/model/api_failure.dart';
import 'package:taller_final/domain/datasource/tv_series_datasource.dart';
import 'package:taller_final/domain/entity/tv_series_details_entity.dart';
import 'package:taller_final/domain/entity/tv_series_entity.dart';
import 'package:taller_final/domain/entity/tv_series_season_details_entity.dart';
import 'package:taller_final/domain/repository/tv_series_repository.dart';

class TvSeriesRepositoryImpl extends TvSeriesRepository {
  final TvSeriesDatasource datasource;

  TvSeriesRepositoryImpl(this.datasource);

  @override
  Future<Either<ApiFailure?, List<TvSeriesEntity>>> getTopRatedTvSeries() async {
    return await datasource.getTopRatedTvSeries();
  }

  @override
  Future<Either<ApiFailure?, TvSeriesDetailsEntity>> getTvSeriesDetails(int seriesId) async {
    return await datasource.getTvSeriesDetails(seriesId);
  }


  @override
  Future<Either<ApiFailure?, TvSeriesSeasonDetailsEntity>> getTvSeriesSeasonDetails(int seriesId, int seasonNumber) async {
    return await datasource.getTvSeriesSeasonDetails(seriesId, seasonNumber);
  }

  @override
  Future<Either<ApiFailure?, List<TvSeriesEntity>>> searchTvSeries(String query) {
    return datasource.searchTvSeries(query);
  }

}
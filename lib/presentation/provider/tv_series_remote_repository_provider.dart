
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taller_final/infrastructure/datasource/tv_series_remote_datasource_impl.dart';

import '../../infrastructure/repository/tv_series_repository_impl.dart';

final tvSeriesRemoteRepositoryProvider = Provider((ref) {
  return TvSeriesRepositoryImpl(TvSeriesRemoteDatasourceImpl());
});
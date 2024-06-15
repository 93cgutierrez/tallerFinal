import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taller_final/config/networking/model/api_failure.dart';
import 'package:taller_final/infrastructure/model/state_enum.dart';
import 'package:taller_final/presentation/provider/tv_series_remote_repository_provider.dart';

import '../../domain/entity/tv_series_details_entity.dart';
import '../../domain/entity/tv_series_entity.dart';
import '../../shared/util/log.dart';

final tvSeriesProvider =
    StateNotifierProvider<TvSeriesNotifier, TvSeriesState>((ref) {
  return TvSeriesNotifier(
    ref: ref,
  );
});

class TvSeriesNotifier extends StateNotifier<TvSeriesState> {
  final StateNotifierProviderRef _ref;

  final String _tag = "tvSeriesNotifier";

  TvSeriesNotifier({
    required StateNotifierProviderRef ref,
  })  : _ref = ref,
        super(TvSeriesState());

  searchTvSeries({required String query}) async {
    try {
      state = state.copyWith(tvSeries: null, state: StateEnum.loading);
      final tvSeriesRepository = _ref.watch(tvSeriesRemoteRepositoryProvider);
      final Either<ApiFailure?, List<TvSeriesEntity>> result =
          await tvSeriesRepository.searchTvSeries(query);

      result.fold((ApiFailure? failure) {
        Log.e(_tag, 'failure: $failure');
        state = state.copyWith(tvSeries: null, state: StateEnum.error);
      }, (List<TvSeriesEntity> tvSeries) {
        state = state.copyWith(
            tvSeries: tvSeries,
            state: tvSeries.isEmpty ? StateEnum.empty : StateEnum.ok);
      });
      //return result;
    } catch (ex) {
      state = state.copyWith(tvSeries: null, state: StateEnum.error);
    }
  }

  getTopRatedTvSeries() async {
    try {
      state = state.copyWith(tvSeries: null, state: StateEnum.loading);
      final tvSeriesRepository = _ref.watch(tvSeriesRemoteRepositoryProvider);
      final Either<ApiFailure?, List<TvSeriesEntity>> result =
          await tvSeriesRepository.getTopRatedTvSeries();

      result.fold((ApiFailure? failure) {
        Log.e(_tag, 'register failure: $failure');
        state = state.copyWith(tvSeries: null, state: StateEnum.error);
      }, (List<TvSeriesEntity> tvSeries) {
        state = state.copyWith(
            tvSeries: tvSeries,
            state: tvSeries.isEmpty ? StateEnum.empty : StateEnum.ok);
      });
      //return result;
    } catch (ex) {
      state = state.copyWith(tvSeries: null);
    }
  }

  Future<void> getTvSeriesDetails({required int seriesId}) async {
    try {
      state =
          state.copyWith(tvSeriesDetailsEntity: null, state: StateEnum.loading);
      final tvSeriesRepository = _ref.watch(tvSeriesRemoteRepositoryProvider);
      final Either<ApiFailure?, TvSeriesDetailsEntity> result =
          await tvSeriesRepository.getTvSeriesDetails(seriesId);

      result.fold((ApiFailure? failure) {
        Log.e(_tag, 'failure: $failure');
        state =
            state.copyWith(tvSeriesDetailsEntity: null, state: StateEnum.error);
      }, (TvSeriesDetailsEntity tvSeries) {
        state = state.copyWith(
            tvSeriesDetailsEntity: tvSeries, state: StateEnum.ok);
      });
      //return result;
    } catch (ex) {
      state =
          state.copyWith(tvSeriesDetailsEntity: null, state: StateEnum.error);
    }
  }

  cleanTvSeriesDetails() {
    state = state.copyWith(tvSeriesDetailsEntity: null);
  }

/*

  Future<Either<ApiFailure?, TvSeriesSeasonDetailsEntity>>
  getTvSeriesSeasonDetails(int seriesId, int seasonNumber);*/
}

class TvSeriesState {
  List<TvSeriesEntity>? tvSeries;
  TvSeriesDetailsEntity? tvSeriesDetailsEntity;
  StateEnum state = StateEnum.idle;

  TvSeriesState({
    this.tvSeries,
    this.tvSeriesDetailsEntity,
    this.state = StateEnum.idle,
  });

  TvSeriesState copyWith({
    List<TvSeriesEntity>? tvSeries,
    TvSeriesDetailsEntity? tvSeriesDetailsEntity,
    StateEnum? state,
  }) {
    return TvSeriesState(
      tvSeries: tvSeries ?? this.tvSeries,
      tvSeriesDetailsEntity:
          tvSeriesDetailsEntity ?? this.tvSeriesDetailsEntity,
      state: state ?? this.state,
    );
  }
}

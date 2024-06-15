import 'package:taller_final/domain/entity/tv_series_season_entity.dart';

class TvSeriesDetailsEntity {
  bool? adult;
  String? backdropPath;
  int? id;
  String? name;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  String? originalName;
  String? overview;
  double? popularity;
  List<TvSeriesSeasonEntity>? seasons;
  String? status;
  double? voteAverage;
  int? voteCount;

  TvSeriesDetailsEntity({
    this.adult,
    this.backdropPath,
    this.id,
    this.name,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originalName,
    this.overview,
    this.popularity,
    this.seasons,
    this.status,
    this.voteAverage,
    this.voteCount,
  });

  TvSeriesDetailsEntity copyWith({
    bool? adult,
    String? backdropPath,
    int? id,
    String? name,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    String? originalName,
    String? overview,
    double? popularity,
    List<TvSeriesSeasonEntity>? seasons,
    String? status,
    double? voteAverage,
    int? voteCount,
  }) =>
      TvSeriesDetailsEntity(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        id: id ?? this.id,
        name: name ?? this.name,
        numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
        numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
        originalName: originalName ?? this.originalName,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        seasons: seasons ?? this.seasons,
        status: status ?? this.status,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory TvSeriesDetailsEntity.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailsEntity(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"],
        seasons: json["seasons"] == null
            ? []
            : List<TvSeriesSeasonEntity>.from(json["seasons"]!.map((x) => TvSeriesSeasonEntity.fromJson(x))),
        status: json["status"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "seasons": seasons == null
            ? []
            : List<dynamic>.from(seasons!.map((x) => x?.toMap())),
        "status": status,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

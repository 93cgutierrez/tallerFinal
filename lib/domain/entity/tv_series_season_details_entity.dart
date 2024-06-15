class TvSeriesSeasonDetailsEntity {
  String? id;
  DateTime? airDate;
  List<Episode>? episodes;
  String? name;
  String? overview;
  int? tvSeasonDetailsResponseId;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  TvSeriesSeasonDetailsEntity({
    this.id,
    this.airDate,
    this.episodes,
    this.name,
    this.overview,
    this.tvSeasonDetailsResponseId,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  TvSeriesSeasonDetailsEntity copyWith({
    String? id,
    DateTime? airDate,
    List<Episode>? episodes,
    String? name,
    String? overview,
    int? tvSeasonDetailsResponseId,
    String? posterPath,
    int? seasonNumber,
    double? voteAverage,
  }) =>
      TvSeriesSeasonDetailsEntity(
        id: id ?? this.id,
        airDate: airDate ?? this.airDate,
        episodes: episodes ?? this.episodes,
        name: name ?? this.name,
        overview: overview ?? this.overview,
        tvSeasonDetailsResponseId:
            tvSeasonDetailsResponseId ?? this.tvSeasonDetailsResponseId,
        posterPath: posterPath ?? this.posterPath,
        seasonNumber: seasonNumber ?? this.seasonNumber,
        voteAverage: voteAverage ?? this.voteAverage,
      );

  factory TvSeriesSeasonDetailsEntity.fromJson(Map<String, dynamic> json) =>
      TvSeriesSeasonDetailsEntity(
        id: json["id"],
        airDate:
            json["air_date"] == null ? null : DateTime.tryParse(json["air_date"]),
        episodes: json["episodes"] == null
            ? null
            : List<Episode>.from(
                json["episodes"].map((x) => Episode.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        tvSeasonDetailsResponseId: json["tv_season_details_response_id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "air_date": airDate?.toIso8601String(),
        "episodes": episodes == null
            ? null
            : List<dynamic>.from(episodes!.map((x) => x.toMap())),
        "name": name,
        "overview": overview,
        "tv_season_details_response_id": tvSeasonDetailsResponseId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}

class Episode {
  DateTime? airDate;
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;

  Episode({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
  });

  Episode copyWith({
    DateTime? airDate,
    int? episodeNumber,
    int? id,
    String? name,
    String? overview,
    String? productionCode,
    int? runtime,
    int? seasonNumber,
    int? showId,
  }) =>
      Episode(
        airDate: airDate ?? this.airDate,
        episodeNumber: episodeNumber ?? this.episodeNumber,
        id: id ?? this.id,
        name: name ?? this.name,
        overview: overview ?? this.overview,
        productionCode: productionCode ?? this.productionCode,
        runtime: runtime ?? this.runtime,
        seasonNumber: seasonNumber ?? this.seasonNumber,
        showId: showId ?? this.showId,
      );

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        airDate:
            json["air_date"] == null ? null : DateTime.tryParse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
      );

  Map<String, dynamic> toMap() => {
        "air_date": airDate?.toIso8601String(),
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
      };
}

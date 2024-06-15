// To parse this JSON data, do
//
//     final tvSeasonDetailsResponse = tvSeasonDetailsResponseFromMap(jsonString);

import 'dart:convert';

import '../../../domain/entity/tv_series_details_entity.dart';
import '../../../domain/entity/tv_series_season_details_entity.dart'
    as tvSeriesSeasonDetails;

TvSeasonDetailsResponse tvSeasonDetailsResponseFromMap(String str) =>
    TvSeasonDetailsResponse.fromMap(json.decode(str));

String tvSeasonDetailsResponseToMap(TvSeasonDetailsResponse data) =>
    json.encode(data.toMap());

class TvSeasonDetailsResponse {
  String? id;
  DateTime? airDate;
  List<Episode>? episodes;
  String? name;
  String? overview;
  int? tvSeasonDetailsResponseId;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  TvSeasonDetailsResponse({
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

  TvSeasonDetailsResponse copyWith({
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
      TvSeasonDetailsResponse(
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

  factory TvSeasonDetailsResponse.fromMap(Map<String, dynamic> json) =>
      TvSeasonDetailsResponse(
        id: json["_id"],
        airDate: json["air_date"] == null
            ? null
            : DateTime.tryParse(json["air_date"]),
        episodes: json["episodes"] == null
            ? []
            : List<Episode>.from(
                json["episodes"]!.map((x) => Episode.fromMap(x))),
        name: json["name"],
        overview: json["overview"],
        tvSeasonDetailsResponseId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episodes": episodes == null
            ? []
            : List<dynamic>.from(episodes!.map((x) => x.toMap())),
        "name": name,
        "overview": overview,
        "id": tvSeasonDetailsResponseId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };

  //TvSeasonDetailsResponse to TvSeriesDetailsEntity
  static tvSeriesSeasonDetails.TvSeriesSeasonDetailsEntity
      fromMapToTvSeriesSeasonDetailsEntity(Map<String, dynamic> json) {
    return tvSeriesSeasonDetails.TvSeriesSeasonDetailsEntity(
      id: json["_id"],
      airDate:
          json["air_date"] == null ? null : DateTime.tryParse(json["air_date"]),
      episodes: json["episodes"] == null
          ? []
          : List<tvSeriesSeasonDetails.Episode>.from(json["episodes"]!
              .map((x) => tvSeriesSeasonDetails.Episode.fromJson(x))),
      name: json["name"],
      overview: json["overview"],
      tvSeasonDetailsResponseId: json["id"],
      posterPath: json["poster_path"],
      seasonNumber: json["season_number"],
      voteAverage: json["vote_average"].toDouble(),
    );
  }
}

class Episode {
  DateTime? airDate;
  int? episodeNumber;
  EpisodeType? episodeType;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  dynamic stillPath;
  double? voteAverage;
  int? voteCount;
  List<dynamic>? crew;
  List<dynamic>? guestStars;

  Episode({
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
    this.crew,
    this.guestStars,
  });

  Episode copyWith({
    DateTime? airDate,
    int? episodeNumber,
    EpisodeType? episodeType,
    int? id,
    String? name,
    String? overview,
    String? productionCode,
    int? runtime,
    int? seasonNumber,
    int? showId,
    dynamic stillPath,
    double? voteAverage,
    int? voteCount,
    List<dynamic>? crew,
    List<dynamic>? guestStars,
  }) =>
      Episode(
        airDate: airDate ?? this.airDate,
        episodeNumber: episodeNumber ?? this.episodeNumber,
        episodeType: episodeType ?? this.episodeType,
        id: id ?? this.id,
        name: name ?? this.name,
        overview: overview ?? this.overview,
        productionCode: productionCode ?? this.productionCode,
        runtime: runtime ?? this.runtime,
        seasonNumber: seasonNumber ?? this.seasonNumber,
        showId: showId ?? this.showId,
        stillPath: stillPath ?? this.stillPath,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        crew: crew ?? this.crew,
        guestStars: guestStars ?? this.guestStars,
      );

  factory Episode.fromMap(Map<String, dynamic> json) => Episode(
        airDate: json["air_date"] == null
            ? null
            : DateTime.tryParse(json["air_date"]),
        episodeNumber: json["episode_number"],
        episodeType: episodeTypeValues.map[json["episode_type"]]!,
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        crew: json["crew"] == null
            ? []
            : List<dynamic>.from(json["crew"]!.map((x) => x)),
        guestStars: json["guest_stars"] == null
            ? []
            : List<dynamic>.from(json["guest_stars"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "episode_type": episodeTypeValues.reverse[episodeType],
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "crew": crew == null ? [] : List<dynamic>.from(crew!.map((x) => x)),
        "guest_stars": guestStars == null
            ? []
            : List<dynamic>.from(guestStars!.map((x) => x)),
      };
}

enum EpisodeType { FINALE, STANDARD }

final episodeTypeValues = EnumValues(
    {"finale": EpisodeType.FINALE, "standard": EpisodeType.STANDARD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

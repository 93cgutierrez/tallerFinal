// To parse this JSON data, do
//
//     final tvSeriesDetailsResponse = tvSeriesDetailsResponseFromMap(jsonString);

import 'dart:convert';

import '../../../domain/entity/tv_series_details_entity.dart';
import '../../../domain/entity/tv_series_season_entity.dart';

TvSeriesDetailsResponse tvSeriesDetailsResponseFromMap(String str) =>
    TvSeriesDetailsResponse.fromMap(json.decode(str));

String tvSeriesDetailsResponseToMap(TvSeriesDetailsResponse data) =>
    json.encode(data.toMap());

class TvSeriesDetailsResponse {
  bool? adult;
  String? backdropPath;
  List<dynamic>? createdBy;
  List<int>? episodeRunTime;
  DateTime? firstAirDate;
  List<Genre>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<String>? languages;
  DateTime? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  dynamic nextEpisodeToAir;
  List<Network>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<dynamic>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  List<Season>? seasons;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  TvSeriesDetailsResponse({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  TvSeriesDetailsResponse copyWith({
    bool? adult,
    String? backdropPath,
    List<dynamic>? createdBy,
    List<int>? episodeRunTime,
    DateTime? firstAirDate,
    List<Genre>? genres,
    String? homepage,
    int? id,
    bool? inProduction,
    List<String>? languages,
    DateTime? lastAirDate,
    LastEpisodeToAir? lastEpisodeToAir,
    String? name,
    dynamic nextEpisodeToAir,
    List<Network>? networks,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    List<dynamic>? productionCompanies,
    List<ProductionCountry>? productionCountries,
    List<Season>? seasons,
    List<SpokenLanguage>? spokenLanguages,
    String? status,
    String? tagline,
    String? type,
    double? voteAverage,
    int? voteCount,
  }) =>
      TvSeriesDetailsResponse(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        createdBy: createdBy ?? this.createdBy,
        episodeRunTime: episodeRunTime ?? this.episodeRunTime,
        firstAirDate: firstAirDate ?? this.firstAirDate,
        genres: genres ?? this.genres,
        homepage: homepage ?? this.homepage,
        id: id ?? this.id,
        inProduction: inProduction ?? this.inProduction,
        languages: languages ?? this.languages,
        lastAirDate: lastAirDate ?? this.lastAirDate,
        lastEpisodeToAir: lastEpisodeToAir ?? this.lastEpisodeToAir,
        name: name ?? this.name,
        nextEpisodeToAir: nextEpisodeToAir ?? this.nextEpisodeToAir,
        networks: networks ?? this.networks,
        numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
        numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
        originCountry: originCountry ?? this.originCountry,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalName: originalName ?? this.originalName,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        productionCompanies: productionCompanies ?? this.productionCompanies,
        productionCountries: productionCountries ?? this.productionCountries,
        seasons: seasons ?? this.seasons,
        spokenLanguages: spokenLanguages ?? this.spokenLanguages,
        status: status ?? this.status,
        tagline: tagline ?? this.tagline,
        type: type ?? this.type,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory TvSeriesDetailsResponse.fromMap(Map<String, dynamic> json) =>
      TvSeriesDetailsResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        createdBy: json["created_by"] == null
            ? []
            : List<dynamic>.from(json["created_by"]!.map((x) => x)),
        episodeRunTime: json["episode_run_time"] == null
            ? []
            : List<int>.from(json["episode_run_time"]!.map((x) => x)),
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.tryParse(json["first_air_date"]),
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"]!.map((x) => x)),
        lastAirDate: json["last_air_date"] == null
            ? null
            : DateTime.tryParse(json["last_air_date"]),
        lastEpisodeToAir: json["last_episode_to_air"] == null
            ? null
            : LastEpisodeToAir.fromMap(json["last_episode_to_air"]),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        networks: json["networks"] == null
            ? []
            : List<Network>.from(
                json["networks"]!.map((x) => Network.fromMap(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: json["production_companies"] == null
            ? []
            : List<dynamic>.from(json["production_companies"]!.map((x) => x)),
        productionCountries: json["production_countries"] == null
            ? []
            : List<ProductionCountry>.from(json["production_countries"]!
                .map((x) => ProductionCountry.fromMap(x))),
        seasons: json["seasons"] == null
            ? []
            : List<Season>.from(json["seasons"]!.map((x) => Season.fromMap(x))),
        spokenLanguages: json["spoken_languages"] == null
            ? []
            : List<SpokenLanguage>.from(json["spoken_languages"]!
                .map((x) => SpokenLanguage.fromMap(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "created_by": createdBy == null
            ? []
            : List<dynamic>.from(createdBy!.map((x) => x)),
        "episode_run_time": episodeRunTime == null
            ? []
            : List<dynamic>.from(episodeRunTime!.map((x) => x)),
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "genres": genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toMap())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
        "last_air_date":
            "${lastAirDate!.year.toString().padLeft(4, '0')}-${lastAirDate!.month.toString().padLeft(2, '0')}-${lastAirDate!.day.toString().padLeft(2, '0')}",
        "last_episode_to_air": lastEpisodeToAir?.toMap(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        "networks": networks == null
            ? []
            : List<dynamic>.from(networks!.map((x) => x.toMap())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": productionCompanies == null
            ? []
            : List<dynamic>.from(productionCompanies!.map((x) => x)),
        "production_countries": productionCountries == null
            ? []
            : List<dynamic>.from(productionCountries!.map((x) => x.toMap())),
        "seasons": seasons == null
            ? []
            : List<dynamic>.from(seasons!.map((x) => x.toMap())),
        "spoken_languages": spokenLanguages == null
            ? []
            : List<dynamic>.from(spokenLanguages!.map((x) => x.toMap())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  static TvSeriesDetailsEntity fromMapToTvSeriesDetailsEntity(
      Map<String, dynamic> json) {
    return TvSeriesDetailsEntity(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      id: json["id"],
      name: json["name"],
      numberOfEpisodes: json["number_of_episodes"],
      numberOfSeasons: json["number_of_seasons"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"]?.toDouble(),
      seasons: json["seasons"] == null
          ? []
          : List<TvSeriesSeasonEntity>.from(
              json["seasons"]!.map((x) => TvSeriesSeasonEntity.fromJson(x))),
      status: json["status"],
      voteAverage: json["vote_average"]?.toDouble(),
      voteCount: json["vote_count"],
    );
  }
}

class Genre {
  int? id;
  String? name;

  Genre({
    this.id,
    this.name,
  });

  Genre copyWith({
    int? id,
    String? name,
  }) =>
      Genre(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class LastEpisodeToAir {
  int? id;
  String? overview;
  String? name;
  double? voteAverage;
  int? voteCount;
  DateTime? airDate;
  int? episodeNumber;
  String? episodeType;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  dynamic stillPath;

  LastEpisodeToAir({
    this.id,
    this.overview,
    this.name,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  LastEpisodeToAir copyWith({
    int? id,
    String? overview,
    String? name,
    double? voteAverage,
    int? voteCount,
    DateTime? airDate,
    int? episodeNumber,
    String? episodeType,
    String? productionCode,
    int? runtime,
    int? seasonNumber,
    int? showId,
    dynamic stillPath,
  }) =>
      LastEpisodeToAir(
        id: id ?? this.id,
        overview: overview ?? this.overview,
        name: name ?? this.name,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        airDate: airDate ?? this.airDate,
        episodeNumber: episodeNumber ?? this.episodeNumber,
        episodeType: episodeType ?? this.episodeType,
        productionCode: productionCode ?? this.productionCode,
        runtime: runtime ?? this.runtime,
        seasonNumber: seasonNumber ?? this.seasonNumber,
        showId: showId ?? this.showId,
        stillPath: stillPath ?? this.stillPath,
      );

  factory LastEpisodeToAir.fromMap(Map<String, dynamic> json) =>
      LastEpisodeToAir(
        id: json["id"],
        overview: json["overview"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        airDate: json["air_date"] == null
            ? null
            : DateTime.tryParse(json["air_date"]),
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "overview": overview,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
      };
}

class Network {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  Network({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  Network copyWith({
    int? id,
    String? logoPath,
    String? name,
    String? originCountry,
  }) =>
      Network(
        id: id ?? this.id,
        logoPath: logoPath ?? this.logoPath,
        name: name ?? this.name,
        originCountry: originCountry ?? this.originCountry,
      );

  factory Network.fromMap(Map<String, dynamic> json) => Network(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class ProductionCountry {
  String? iso31661;
  String? name;

  ProductionCountry({
    this.iso31661,
    this.name,
  });

  ProductionCountry copyWith({
    String? iso31661,
    String? name,
  }) =>
      ProductionCountry(
        iso31661: iso31661 ?? this.iso31661,
        name: name ?? this.name,
      );

  factory ProductionCountry.fromMap(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

class Season {
  DateTime? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  Season copyWith({
    DateTime? airDate,
    int? episodeCount,
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
    double? voteAverage,
  }) =>
      Season(
        airDate: airDate ?? this.airDate,
        episodeCount: episodeCount ?? this.episodeCount,
        id: id ?? this.id,
        name: name ?? this.name,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        seasonNumber: seasonNumber ?? this.seasonNumber,
        voteAverage: voteAverage ?? this.voteAverage,
      );

  factory Season.fromMap(Map<String, dynamic> json) => Season(
        airDate: json["air_date"] == null
            ? null
            : DateTime.tryParse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}

class SpokenLanguage {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  SpokenLanguage copyWith({
    String? englishName,
    String? iso6391,
    String? name,
  }) =>
      SpokenLanguage(
        englishName: englishName ?? this.englishName,
        iso6391: iso6391 ?? this.iso6391,
        name: name ?? this.name,
      );

  factory SpokenLanguage.fromMap(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}

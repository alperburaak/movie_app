import 'package:hive/hive.dart';

part 'movie_model.g.dart'; // Hive için kod üretim dosyası

class MovieModel {
  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  MovieModel({this.page, this.results, this.totalPages, this.totalResults});

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    page: json["page"] as int?,
    results:
        (json["results"] as List<dynamic>?)
            ?.map((x) => Result.fromJson(x))
            .toList(),
    totalPages: json["total_pages"] as int?,
    totalResults: json["total_results"] as int?,
  );
}

@HiveType(typeId: 0)
class Result {
  @HiveField(0)
  final bool? adult;

  @HiveField(1)
  final String? backdropPath;

  @HiveField(2)
  final List<int>? genreIds;

  @HiveField(3)
  final int? id;

  @HiveField(4)
  final String? originalLanguage;

  @HiveField(5)
  final String? originalTitle;

  @HiveField(6)
  final String? overview;

  @HiveField(7)
  final double? popularity;

  @HiveField(8)
  final String? posterPath;

  @HiveField(9)
  final DateTime? releaseDate;

  @HiveField(10)
  final String? title;

  @HiveField(11)
  final bool? video;

  @HiveField(12)
  final double? voteAverage;

  @HiveField(13)
  final int? voteCount;

  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"] as bool?,
    backdropPath: json["backdrop_path"] as String? ?? '',
    genreIds:
        (json["genre_ids"] as List<dynamic>?)?.map((x) => x as int).toList(),
    id: json["id"] as int?,
    originalLanguage: json["original_language"] as String?,
    originalTitle: json["original_title"] as String?,
    overview: json["overview"] as String?,
    popularity: (json["popularity"] as num?)?.toDouble(),
    posterPath: json["poster_path"] as String? ?? '',
    releaseDate:
        json["release_date"] != null
            ? DateTime.tryParse(json["release_date"])
            : null,
    title: json["title"] as String?,
    video: json["video"] as bool?,
    voteAverage: (json["vote_average"] as num?)?.toDouble(),
    voteCount: json["vote_count"] as int?,
  );
}

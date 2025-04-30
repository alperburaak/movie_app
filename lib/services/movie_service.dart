import 'package:dio/dio.dart';
import 'package:movie_app/core/dio_client.dart';
import '../models/movie_model.dart';

class MovieService {
  final Dio _dio = DioClient().client;

  Future<MovieModel> fetchTopRatedMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        'movie/top_rated',
        queryParameters: {'page': page},
      );
      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Top rated filmler alınamadı: $e');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:movie_app/core/dio_client.dart';
import '../models/movie_model.dart';

class MovieService {
  final Dio _dio = DioClient().client;

  Future<MovieModel> fetchTopRatedMovies({int page = 1}) async {
    try {
      final response = await _dio.get(
        'movie/top_rated',
        queryParameters: {'page': page, 'language': 'tr'},
      );
      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Filmler alınamadı');
    }
  }

  Future<MovieModel> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await _dio.get(
        'search/movie',
        queryParameters: {'query': query, 'page': page, 'language': 'tr'},
      );
      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Film bulunamadı');
    }
  }
}

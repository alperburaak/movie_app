import 'package:dio/dio.dart';
import 'package:movie_app/core/dio_client.dart';
import '../models/movie_model.dart';

class MovieService {
  final Dio _dio = DioClient().client;

  Future<MovieModel> fetchTopRatedMovies() async {
    try {
      final response = await _dio.get('movie/top_rated');
      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Top rated filmler alınamadı: $e');
    }
  }
}

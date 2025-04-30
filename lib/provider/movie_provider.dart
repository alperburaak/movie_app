import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  final MovieService _movieService = MovieService();

  List<Result> _movies = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  bool _hasMore = true;

  List<Result> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;

  Future<void> fetchTopRatedMovies({bool loadMore = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final pageToFetch = loadMore ? _currentPage + 1 : 1;
      final movieModel = await _movieService.fetchTopRatedMovies(
        page: pageToFetch,
      );

      if (loadMore) {
        _movies.addAll(movieModel.results);
        _currentPage++;
      } else {
        _movies = movieModel.results;
        _currentPage = 1;
      }

      _hasMore = _currentPage < movieModel.totalPages;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  final MovieService _movieService = MovieService();

  List<Result> _movies = [];
  bool _isLoading = false;
  String? _error;

  List<Result> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTopRatedMovies() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final movieModel = await _movieService.fetchTopRatedMovies();
      _movies = movieModel.results;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

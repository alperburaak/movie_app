import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  final Box<Result> _favoritesBox = Hive.box<Result>('favoritesBox');

  List<Result> get favoriteMovies => _favoritesBox.values.toList();

  bool isFavorite(int? id) => id != null && _favoritesBox.containsKey(id);

  Future<void> fetchTopRatedMovies({bool loadMore = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });

    try {
      final pageToFetch = loadMore ? _currentPage + 1 : 1;
      final movieModel = await _movieService.fetchTopRatedMovies(
        page: pageToFetch,
      );

      if (loadMore) {
        _movies.addAll(movieModel.results ?? []);
        _currentPage++;
      } else {
        _movies = movieModel.results ?? [];
        _currentPage = 1;
      }

      _hasMore = _currentPage < (movieModel.totalPages ?? 1);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> searchMovies(String query, {int page = 1}) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Arama yapıldığında mevcut listeyi temizle
      if (page == 1) {
        _movies = [];
        _currentPage = 1;
        _hasMore = true;
      }

      final movieModel = await _movieService.searchMovies(query, page: page);

      _movies.addAll(movieModel.results ?? []);
      _currentPage = page;
      _hasMore = _currentPage < (movieModel.totalPages ?? 1);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Result movie) async {
    if (movie.id == null) return;

    if (isFavorite(movie.id)) {
      await _favoritesBox.delete(movie.id);
    } else {
      await _favoritesBox.put(movie.id, movie);
    }
    notifyListeners();
  }
}

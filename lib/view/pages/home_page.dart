import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/view/pages/movie_detail_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MovieProvider>(context, listen: false);
    provider.fetchTopRatedMovies();

    _scrollController =
        ScrollController()..addListener(() {
          // Eğer arama yapılıyorsa, kaydırma sırasında tüm filmleri yükleme
          if (_searchController.text.isEmpty &&
              _scrollController.position.pixels >=
                  _scrollController.position.maxScrollExtent - 300 &&
              !provider.isLoading &&
              provider.hasMore) {
            provider.fetchTopRatedMovies(loadMore: true);
          }
        });
    _searchController.addListener(() {
      final query = _searchController.text.trim();
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 500), () {
        if (query.isEmpty) {
          // Arama kutusu boşsa, önceki listeyi temizle ve en iyi filmleri getir
          provider.fetchTopRatedMovies(loadMore: false);
        } else if (query.length >= 2) {
          // Arama yapıldığında
          provider.searchMovies(query);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();

    _searchController.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('En İyi Dereceli Filmler'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Film ara...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (movieProvider.isLoading && movieProvider.movies.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (movieProvider.error != null) {
                  return Center(child: Text(movieProvider.error!));
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        movieProvider.movies.length +
                        (movieProvider.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < movieProvider.movies.length) {
                        final movie = movieProvider.movies[index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailPage(movie: movie),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(
                              movieProvider.isFavorite(movie.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              movieProvider.toggleFavorite(movie);
                            },
                          ),
                          leading: CachedNetworkImage(
                            imageUrl:
                                movie.posterPath != null
                                    ? 'https://image.tmdb.org/t/p/w92${movie.posterPath}'
                                    : 'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg',
                            placeholder:
                                (context, url) =>
                                    const CircularProgressIndicator(),
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error),
                          ),
                          title: Text(movie.title ?? 'Başlık Yok'),
                          subtitle: Text(
                            movie.releaseDate.toString().split(' ')[0],
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:provider/provider.dart';
import 'movie_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    final favorites = provider.favoriteMovies;
    return Scaffold(
      appBar: AppBar(title: const Text('Favoriler')),
      body:
          favorites.isEmpty
              ? const Center(child: Text('Henüz favori film eklenmedi'))
              : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final movie = favorites[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailPage(movie: movie),
                        ),
                      );
                    },
                    leading: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                      placeholder:
                          (context, url) => const CircularProgressIndicator(),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                    ),
                    title: Text(movie.title ?? 'Başlık Yok'),
                    subtitle: Text(movie.releaseDate.toString().split(' ')[0]),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        provider.toggleFavorite(movie);
                      },
                    ),
                  );
                },
              ),
    );
  }
}

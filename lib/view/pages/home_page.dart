import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Sayfa yüklendiğinde filmleri çek
    Future.microtask(
      () =>
          Provider.of<MovieProvider>(
            context,
            listen: false,
          ).fetchTopRatedMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated Movies'), centerTitle: true),
      body: Builder(
        builder: (_) {
          if (movieProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (movieProvider.error != null) {
            return Center(child: Text(movieProvider.error!));
          } else {
            return ListView.builder(
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.movies[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                    placeholder:
                        (context, url) => const CircularProgressIndicator(),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.releaseDate.toString().split(' ')[0]),
                );
              },
            );
          }
        },
      ),
    );
  }
}

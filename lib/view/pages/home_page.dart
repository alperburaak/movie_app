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

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MovieProvider>(context, listen: false);
    provider.fetchTopRatedMovies();

    _scrollController =
        ScrollController()..addListener(() {
          if (_scrollController.position.pixels >=
                  _scrollController.position.maxScrollExtent - 300 &&
              !provider.isLoading &&
              provider.hasMore) {
            provider.fetchTopRatedMovies(loadMore: true);
          }
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated Movies'), centerTitle: true),
      body: Builder(
        builder: (_) {
          if (movieProvider.isLoading && movieProvider.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (movieProvider.error != null) {
            return Center(child: Text(movieProvider.error!));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount:
                  movieProvider.movies.length + (movieProvider.hasMore ? 1 : 0),
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
    );
  }
}

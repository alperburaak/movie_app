import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final Result movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title ?? 'Film Detayı')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl:
                    movie.posterPath != null && movie.posterPath!.isNotEmpty
                        ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                        : 'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg',
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget:
                    (context, url, error) =>
                        const Icon(Icons.image_not_supported),
                height: 300,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.title ?? 'Başlık Yok',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Yayın Tarihi: ${movie.releaseDate != null ? movie.releaseDate!.toString().split(' ')[0] : 'Bilinmiyor'}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${movie.voteAverage?.toStringAsFixed(1) ?? '0.0'} (${movie.voteCount ?? 0} oy)',
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Açıklama',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              movie.overview?.isNotEmpty == true
                  ? movie.overview!
                  : 'Açıklama bulunmamaktadır.',
            ),
          ],
        ),
      ),
    );
  }
}

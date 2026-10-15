import 'package:flutter/material.dart';

void main() => runApp(const MovieApp());
class Trailer {
  final String title;
  final String duration;
  final String thumbnailUrl;

  const Trailer({
    required this.title,
    required this.duration,
    required this.thumbnailUrl,
  });
}

class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<Trailer> trailers;

  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}

const List<Movie> sampleMovies = [
  Movie(
    id: 1,
    title: 'Inception',
    posterUrl: 'https://tse2.mm.bing.net/th/id/OIP.efjc35QM9GrBPV3mFz12ZQHaK9?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    overview:
        'A skilled thief who steals secrets from within dreams is offered a '
        'chance to have his criminal record erased if he can plant an idea '
        'in a target\'s subconscious. A mind-bending heist across layers of '
        'reality.',
    genres: ['Sci-Fi', 'Action', 'Thriller','Psycological'],
    rating: 8.8,
    trailers: [
      Trailer(
        title: 'Official Trailer',
        duration: '2:28',
        thumbnailUrl: 'https://static1.srcdn.com/wordpress/wp-content/uploads/2023/04/inception-characters-film-crew.jpg',
      ),
      Trailer(
        title: 'Final Trailer',
        duration: '1:45',
        thumbnailUrl: 'https://tse4.mm.bing.net/th/id/OIP.RvWI9o-24V4byAJE00rdjwHaE6?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
      ),
    ],
  ),
  Movie(
    id: 2,
    title: 'Interstellar',
    posterUrl: 'https://th.bing.com/th/id/OIP.jPJNT4tJgwIUeHtZpm0n8QHaLH?r=0&o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
    overview:
        'With Earth running out of resources, a team of explorers travels '
        'through a wormhole near Saturn in search of a new home for humanity.',
    genres: ['Sci-Fi', 'Drama', 'Adventure'],
    rating: 8.6,
    trailers: [
      Trailer(
        title: 'Teaser Trailer',
        duration: '1:30',
        thumbnailUrl: 'https://i.ytimg.com/vi/Rvns5DaW-ug/maxresdefault.jpg',
      ),
      Trailer(
        title: 'Official Trailer',
        duration: '2:34',
        thumbnailUrl: 'https://www.geeksandcom.com/wp-content/uploads/2014/11/Interstellar-1.jpg',
      ),
      Trailer(
        title: 'Behind the Scenes',
        duration: '4:10',
        thumbnailUrl: 'https://static1.srcdn.com/wordpress/wp-content/uploads/2025/01/matt-damon-matthew-mcconaughey-jessican-chastain-in-interstellar.jpg',
      ),
    ],
  ),
  Movie(
    id: 3,
    title: 'The Dark Knight',
    posterUrl: 'https://m.media-amazon.com/images/I/91KkWf50SoL._AC_SL1500_.jpg',
    overview:
        'When the Joker wreaks havoc on Gotham, Batman must accept one of the '
        'greatest psychological and physical tests of his ability to fight '
        'injustice.',
    genres: ['Action', 'Thriller', 'Drama','Violent'],
    rating: 9.0,
    trailers: [
      Trailer(
        title: 'Official Trailer',
        duration: '2:32',
        thumbnailUrl: 'https://static1.cbrimages.com/wordpress/wp-content/uploads/2024/10/10-best-reasons-to-rewatch-the-dark-knight-trilogy.jpg',
      ),
    ],
  ),
];

class FavoritesModel extends ChangeNotifier {
  final Set<int> _ids = {};

  bool isFavorite(Movie m) => _ids.contains(m.id);

  void toggle(Movie m) {
    if (!_ids.remove(m.id)) _ids.add(m.id);
    notifyListeners();
  }
}

final favorites = FavoritesModel();

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Detail App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/detail':
            final movie = settings.arguments as Movie;
            return MaterialPageRoute(
              builder: (_) => MovieDetailScreen(movie: movie),
            );
        }
        return null;
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final movies = sampleMovies
        .where((m) => m.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search movies',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: movies.isEmpty
                ? const Center(child: Text('No movies found'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: movies.length,
                    itemBuilder: (context, i) => MovieCard(movie: movies[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie),
        child: Row(
          children: [
            Hero(
              tag: 'poster_${movie.id}',
              child: Image.network(
                movie.posterUrl,
                width: 90,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(
                  width: 90,
                  height: 130,
                  child: Icon(Icons.movie, size: 40),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(movie.rating.toStringAsFixed(1)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    movie.genres.join(' • '),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Rebuilds only when favourites change.
            ListenableBuilder(
              listenable: favorites,
              builder: (context, _) => Icon(
                favorites.isFavorite(movie)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favorites.isFavorite(movie) ? Colors.redAccent : null,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}


class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'poster_${movie.id}',
                    child: Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Center(child: Icon(Icons.movie, size: 64)),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Text(
                      movie.title,
                      style: textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${movie.rating} / 10', style: textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final g in movie.genres) Chip(label: Text(g)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text('Overview', style: textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(movie.overview, style: textTheme.bodyLarge),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListenableBuilder(
                        listenable: favorites,
                        builder: (context, _) {
                          final fav = favorites.isFavorite(movie);
                          return _ActionButton(
                            icon: fav ? Icons.favorite : Icons.favorite_border,
                            label: 'Favorite',
                            color: fav ? Colors.redAccent : null,
                            onPressed: () => favorites.toggle(movie),
                          );
                        },
                      ),
                      _ActionButton(
                        icon: Icons.star_border,
                        label: 'Rate',
                        onPressed: () => _snack(context, 'Rate tapped'),
                      ),
                      _ActionButton(
                        icon: Icons.share,
                        label: 'Share',
                        onPressed: () =>
                            _snack(context, 'Sharing "${movie.title}"…'),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Text('Trailers', style: textTheme.titleLarge),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: movie.trailers.length,
                    itemBuilder: (context, i) {
                      final t = movie.trailers[i];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            t.thumbnailUrl,
                            width: 90,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const SizedBox(
                              width: 90,
                              height: 56,
                              child: Icon(Icons.play_circle),
                            ),
                          ),
                        ),
                        title: Text(t.title),
                        subtitle: Text(t.duration),
                        trailing: const Icon(Icons.play_circle_outline),
                        onTap: () => _snack(context, 'Playing ${t.title}…'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(icon, color: color), onPressed: onPressed),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const ResponsiveMovieApp());

const double kTabletBreakpoint = 800;

class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

const List<Movie> allMovies = [
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    posterUrl: 'https://tse2.mm.bing.net/th/id/OIP.efjc35QM9GrBPV3mFz12ZQHaK9?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    rating: 8.8,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Drama', 'Crime'],
    posterUrl: 'https://m.media-amazon.com/images/I/91KkWf50SoL._AC_SL1500_.jpg',
    rating: 9.0,
  ),
  Movie(
    title: 'Superbad',
    year: 2007,
    genres: ['Comedy'],
    posterUrl: 'https://images6.alphacoders.com/817/817326.jpg',
    rating: 7.6,
  ),
  Movie(
    title: 'Parasite',
    year: 2019,
    genres: ['Drama', 'Thriller'],
    posterUrl: 'https://images2.alphacoders.com/112/1122541.jpg',
    rating: 8.5,
  ),
  Movie(
    title: 'The Grand Budapest Hotel',
    year: 2014,
    genres: ['Comedy', 'Drama'],
    posterUrl: 'https://peterviney.files.wordpress.com/2014/03/grand-budapest-hotel.png',
    rating: 8.1,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama'],
    posterUrl: 'https://th.bing.com/th/id/OIP.jPJNT4tJgwIUeHtZpm0n8QHaLH?r=0&o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
    rating: 8.6,
  ),
  Movie(
    title: 'Mad Max: Fury Road',
    year: 2015,
    genres: ['Action', 'Sci-Fi'],
    posterUrl: 'https://facts.net/wp-content/uploads/2023/06/30-facts-about-the-movie-mad-max-fury-road-1687337894.jpeg',
    rating: 8.1,
  ),
  Movie(
    title: 'Get Out',
    year: 2017,
    genres: ['Horror', 'Thriller'],
    posterUrl: 'https://tse1.mm.bing.net/th/id/OIP.6MzYme-9gba_Dkk3wqMRkgHaDt?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    rating: 7.7,
  ),
];

const List<String> allGenres = [
  'Action',
  'Drama',
  'Comedy',
  'Sci-Fi',
  'Thriller',
  'Horror',
  'Crime',
];

const List<String> sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];
class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find a Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const GenreScreen(),
    );
  }
}


class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  final Set<String> selectedGenres = {};
  String selectedSort = 'A-Z';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }



  List<Movie> get visibleMovies {
    final query = searchQuery.trim().toLowerCase();

    final result = allMovies.where((m) {
      final matchesSearch = m.title.toLowerCase().contains(query);
      final matchesGenre = selectedGenres.isEmpty ||
          m.genres.any(selectedGenres.contains); // at least one selected genre
      return matchesSearch && matchesGenre;
    }).toList();

    switch (selectedSort) {
      case 'A-Z':
        result.sort((a, b) =>
            a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      case 'Z-A':
        result.sort((a, b) =>
            b.title.toLowerCase().compareTo(a.title.toLowerCase()));
      case 'Year':
        result.sort((a, b) => b.year.compareTo(a.year));
      case 'Rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return result;
  }

  void _toggleGenre(String genre) {
    setState(() {
      if (!selectedGenres.remove(genre)) selectedGenres.add(genre);
    });
  }

  void _clearFilters() {
    setState(() {
      selectedGenres.clear();
      searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = visibleMovies;
    final hasFilters = selectedGenres.isNotEmpty || searchQuery.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find a Movie',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              _buildSearchBar(),
              const SizedBox(height: 16),

              _buildGenreChips(),
              const SizedBox(height: 8),

              _buildSortRow(movies.length, hasFilters),
              const SizedBox(height: 8),

              Expanded(child: _buildMovieArea(movies)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search a title or keyword',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchQuery.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => searchQuery = '');
                  },
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildGenreChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        for (final genre in allGenres)
          FilterChip(
            label: Text(genre),
            selected: selectedGenres.contains(genre),
            onSelected: (_) => _toggleGenre(genre),
          ),
      ],
    );
  }

  Widget _buildSortRow(int count, bool hasFilters) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 4,
      children: [
        Badge(
          isLabelVisible: selectedGenres.isNotEmpty,
          label: Text('${selectedGenres.length}'),
          child: const Padding(
            padding: EdgeInsets.all(6),
            child: Icon(Icons.filter_list),
          ),
        ),
        const Text('Sort by:'),
        DropdownButton<String>(
          value: selectedSort,
          underline: const SizedBox.shrink(),
          items: [
            for (final s in sortOptions)
              DropdownMenuItem(value: s, child: Text(s)),
          ],
          onChanged: (value) {
            if (value != null) setState(() => selectedSort = value);
          },
        ),
        Text('$count result${count == 1 ? '' : 's'}'),
        if (hasFilters)
          TextButton.icon(
            onPressed: _clearFilters,
            icon: const Icon(Icons.clear_all),
            label: const Text('Clear filters'),
          ),
      ],
    );
  }

  Widget _buildMovieArea(List<Movie> movies) {
    if (movies.isEmpty) {
      return const Center(child: Text('No movies match your filters.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= kTabletBreakpoint;

        if (!isWide) {
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MovieCard(movie: movies[i], height: 130),
            ),
          );
        }

        const spacing = 16.0;
        const cardHeight = 170.0;
        final itemWidth = (constraints.maxWidth - spacing) / 2;
        return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: itemWidth / cardHeight,
          children: [
            for (final m in movies) MovieCard(movie: m, height: cardHeight),
          ],
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double height;

  const MovieCard({super.key, required this.movie, required this.height});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Wider card -> bigger poster (2:3 ratio), capped by card height.
        final posterWidth = constraints.maxWidth > 450 ? 110.0 : 85.0;

        return Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: SizedBox(
            height: height,
            child: Row(
              children: [
                Image.network(
                  movie.posterUrl,
                  width: posterWidth,
                  height: height,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => SizedBox(
                    width: posterWidth,
                    height: height,
                    child: const Icon(Icons.movie, size: 36),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.title,
                          style: textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text('${movie.year}', style: textTheme.bodyMedium),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(movie.rating.toStringAsFixed(1)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.genres.join(' • '),
                          style: textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

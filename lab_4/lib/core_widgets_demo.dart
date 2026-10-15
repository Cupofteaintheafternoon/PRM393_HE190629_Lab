import 'package:flutter/material.dart';

/// Exercise 1 – Core Widgets: Text, Image, Icon, Card, ListTile
class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ex 1 – Core Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // A headline Text
            Text(
              'Now Showing',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // An Icon using Material Icons (inside a Row with text)
            const Row(
              children: [
                Icon(Icons.movie_filter, color: Colors.deepPurple, size: 32),
                SizedBox(width: 8),
                Text('Flutter Cinema', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 16),

            // An Image.network() with rounded corners, loading & error states
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/id/1015/800/400',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                errorBuilder: (context, error, stack) => const SizedBox(
                  height: 200,
                  child: Center(child: Icon(Icons.broken_image, size: 48)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // A Card containing a ListTile
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.local_movies)),
                title: const Text('Inception'),
                subtitle: const Text('2010 • Sci-Fi • 8.8 ★'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Inception tapped')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

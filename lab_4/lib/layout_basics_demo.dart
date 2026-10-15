import 'package:flutter/material.dart';

/// Exercise 3 – Layout Basics: Column, Row, Padding, ListView
class LayoutBasicsDemo extends StatelessWidget {
  const LayoutBasicsDemo({super.key});

  static const _movies = [
    'The Shawshank Redemption',
    'The Dark Knight',
    'Inception',
    'Interstellar',
    'Parasite',
    'Spirited Away',
    'The Matrix',
    'Whiplash',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ex 3 – Layout Basics')),
      // Column creates vertical sections; Padding gives a consistent 16px gutter.
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: header Row
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Home',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Icon(Icons.search),
              ],
            ),
            const SizedBox(height: 16),

            // Section 2: stats Row
            Row(
              children: const [
                Expanded(child: _StatBox(label: 'Movies', value: '128')),
                SizedBox(width: 12),
                Expanded(child: _StatBox(label: 'Watched', value: '42')),
                SizedBox(width: 12),
                Expanded(child: _StatBox(label: 'Saved', value: '9')),
              ],
            ),
            const SizedBox(height: 16),

            // Section 3: title + list
            const Text('Top Rated',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            // ListView inside a Column MUST be wrapped in Expanded.
            Expanded(
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${i + 1}')),
                      title: Text(_movies[i]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}

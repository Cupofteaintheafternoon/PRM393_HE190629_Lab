import 'package:flutter/material.dart';

import 'core_widgets_demo.dart';
import 'debug_fixes_demo.dart';
import 'input_controls_demo.dart';
import 'layout_basics_demo.dart';
import 'scaffold_theme_demo.dart';

void main() => runApp(const Lab4App());

/// Launcher that lets you open each of the five exercises.
class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 – Flutter UI Fundamentals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <(String, String, Widget)>[
      ('Exercise 1', 'Core Widgets', const CoreWidgetsDemo()),
      ('Exercise 2', 'Input Widgets', const InputControlsDemo()),
      ('Exercise 3', 'Layout Basics', const LayoutBasicsDemo()),
      ('Exercise 4', 'Scaffold, FAB & Theme', const ScaffoldThemeDemo()),
      ('Exercise 5', 'Debug & Fix UI Errors', const DebugFixesDemo()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 – UI Fundamentals')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final (title, subtitle, page) = items[i];
          return Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => page)),
            ),
          );
        },
      ),
    );
  }
}

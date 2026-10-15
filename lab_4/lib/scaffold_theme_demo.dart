import 'package:flutter/material.dart';
/// Exercise 4 – App Structure with Scaffold, AppBar, FAB & Theme
class ScaffoldThemeDemo extends StatefulWidget {
  const ScaffoldThemeDemo({super.key});

  @override
  State<ScaffoldThemeDemo> createState() => _ScaffoldThemeDemoState();
}

class _ScaffoldThemeDemoState extends State<ScaffoldThemeDemo> {
  ThemeMode _themeMode = ThemeMode.light;
  int _counter = 0;

  bool get _isDark => _themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext outerContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Ex 4 – Scaffold & Theme'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(outerContext).pop(),
            ),
            actions: [
              IconButton(
                tooltip: 'Toggle dark mode',
                icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => setState(() {
                  _themeMode = _isDark ? ThemeMode.light : ThemeMode.dark;
                }),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Button pressed', style: Theme.of(context).textTheme.titleMedium),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: _isDark,
                  onChanged: (v) => setState(() {
                    _themeMode = v ? ThemeMode.dark : ThemeMode.light;
                  }),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() => _counter++),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

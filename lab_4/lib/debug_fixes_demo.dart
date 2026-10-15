import 'package:flutter/material.dart';
/// Exercise 5 – Debug & Fix Common UI Errors
class DebugFixesDemo extends StatefulWidget {
  const DebugFixesDemo({super.key});

  @override
  State<DebugFixesDemo> createState() => _DebugFixesDemoState();
}

class _DebugFixesDemoState extends State<DebugFixesDemo> {
  int _count = 0;
  DateTime? _date;

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _date = d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ex 5 – Debug & Fix')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Counter: $_count',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => setState(() => _count++),
                      child: const Text('Increment (uses setState)'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.event),
              label: Text(_date == null
                  ? 'Pick a date'
                  : 'Picked: ${_date!.toLocal().toString().split(' ').first}'),
            ),
            const SizedBox(height: 16),

            const Text('FIX 1 – ListView inside Column',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, i) => ListTile(
                  leading: const Icon(Icons.movie),
                  title: Text('Movie ${i + 1}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandedListFix extends StatelessWidget {
  const ExpandedListFix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fix 1 – Expanded')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Header'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (_, i) => ListTile(title: Text('Item $i')),
            ),
          ),
        ],
      ),
    );
  }
}

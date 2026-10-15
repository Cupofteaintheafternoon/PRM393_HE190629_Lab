import 'package:flutter/material.dart';

/// Exercise 5 – Debug & Fix Common UI Errors
///
/// Each fix below is explained in a comment: "BROKEN" shows what causes the
/// error, "FIXED" is what is actually used.
class DebugFixesDemo extends StatefulWidget {
  const DebugFixesDemo({super.key});

  @override
  State<DebugFixesDemo> createState() => _DebugFixesDemoState();
}

class _DebugFixesDemoState extends State<DebugFixesDemo> {
  int _count = 0;
  DateTime? _date;

  // FIX 4 – DatePicker context error.
  // BROKEN: calling showDatePicker with a context that has no Navigator/Overlay
  //   above it (e.g. the context of the widget that *creates* MaterialApp).
  //   Error: "No MaterialLocalizations found" / "Navigator operation requested
  //   with a context that does not include a Navigator".
  // FIXED: call it from a method of a widget that sits *below* MaterialApp,
  //   i.e. this State's own `context`.
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
      // FIX 2 – Overflow on small screens.
      // BROKEN: a plain Column taller than the screen -> yellow/black
      //   "RenderFlex overflowed by N pixels".
      // FIXED: wrap in SingleChildScrollView so content can scroll.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // FIX 3 – State update.
            // BROKEN: `onPressed: () { _count++; }` changes the variable but
            //   never tells Flutter to rebuild, so the Text stays the same.
            // FIXED: wrap the change in setState().
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

            // FIX 4 – Date picker (see _pickDate above).
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

            // FIX 1 – ListView inside Column.
            // BROKEN: a ListView directly inside a Column has unbounded height
            //   -> "Vertical viewport was given unbounded height".
            // FIXED: give it bounded height. Here the Column is already inside
            //   a scroll view, so Expanded can't be used; we use a SizedBox.
            //   (In a non-scrolling Column, use Expanded(child: ListView(...)),
            //   as shown in Exercise 3.)
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

/// Stand-alone version of Fix 1 exactly as the lab words it
/// ("Fix ListView inside Column using Expanded").
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
          // BROKEN: ListView(...)           -> unbounded height error
          // FIXED:  Expanded(child: ListView(...))
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

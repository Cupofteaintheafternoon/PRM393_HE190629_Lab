import 'package:flutter/material.dart';

/// Exercise 2 – Input Widgets: Slider, Switch, RadioListTile, DatePicker
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

enum Format { twoD, threeD, imax }

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _volume = 50; // Slider value
  bool _subtitles = true; // Switch value
  Format _format = Format.twoD; // Radio group value
  DateTime? _date; // Picked date

  // Called from inside the State's build tree, so `context` is valid
  // (this is the fix for the "DatePicker context" error in Exercise 5).
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // setState tells Flutter to rebuild so the new value is displayed.
      setState(() => _date = picked);
    }
  }

  String _formatLabel(Format f) => switch (f) {
        Format.twoD => '2D',
        Format.threeD => '3D',
        Format.imax => 'IMAX',
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ex 2 – Input Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Slider
          Text('Volume: ${_volume.round()}'),
          Slider(
            value: _volume,
            min: 0,
            max: 100,
            divisions: 100,
            label: _volume.round().toString(),
            onChanged: (v) => setState(() => _volume = v),
          ),

          // Switch
          SwitchListTile(
            title: const Text('Subtitles'),
            value: _subtitles,
            onChanged: (v) => setState(() => _subtitles = v),
          ),
          const Divider(),

          // RadioListTile group
          const Text('Format', style: TextStyle(fontWeight: FontWeight.bold)),
          for (final f in Format.values)
            RadioListTile<Format>(
              title: Text(_formatLabel(f)),
              value: f,
              groupValue: _format,
              onChanged: (v) => setState(() => _format = v!),
            ),
          const Divider(),

          // Button that opens the DatePicker
          ElevatedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today),
            label: const Text('Pick showtime date'),
          ),
          const SizedBox(height: 16),

          // Display updated values
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Volume: ${_volume.round()}'),
                  Text('Subtitles: ${_subtitles ? "On" : "Off"}'),
                  Text('Format: ${_formatLabel(_format)}'),
                  Text(
                    'Date: ${_date == null ? "not selected" : "${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}"}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

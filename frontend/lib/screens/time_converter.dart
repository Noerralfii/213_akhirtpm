import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeConverterPage extends StatefulWidget {
  const TimeConverterPage({super.key});

  @override
  State<TimeConverterPage> createState() => _TimeConverterPageState();
}

class _TimeConverterPageState extends State<TimeConverterPage> {
  DateTime selectedTime = DateTime.now();
  final DateFormat formatter = DateFormat('HH:mm:ss');
  Map<String, String> results = {};

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _convertTime();
  }

  void _convertTime() {
    final locations = {
      'WIB': 'Asia/Jakarta',
      'WITA': 'Asia/Makassar',
      'WIT': 'Asia/Jayapura',
      'London': 'Europe/London',
    };
    setState(() {
      results = locations.map((name, zone) {
        final loc = tz.getLocation(zone);
        final time = tz.TZDateTime.from(selectedTime, loc);
        return MapEntry(name, formatter.format(time));
      });
    });
  }

  void _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime),
    );
    if (picked != null) {
      final now = DateTime.now();
      setState(() {
        selectedTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      });
      _convertTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Waktu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _selectTime,
              child: const Text('Pilih Jam'),
            ),
            const SizedBox(height: 20),
            ...results.entries.map((entry) => ListTile(
                  title: Text(entry.key),
                  trailing: Text(entry.value),
                )),
          ],
        ),
      ),
    );
  }
}
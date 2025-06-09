import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amount = TextEditingController();
  String _from = 'USD';
  String _to = 'IDR';
  String _result = '';

  Future<void> convert() async {
    final response = await http.get(Uri.parse(
        'https://api.exchangerate-api.com/v4/latest/$_from'));
    if (response.statusCode == 200) {
      final rates = json.decode(response.body)['rates'];
      double rate = rates[_to];
      double amount = double.tryParse(_amount.text) ?? 0;
      setState(() => _result = '${(amount * rate).toStringAsFixed(2)} $_to');
    } else {
      setState(() => _result = 'Gagal mengambil data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Mata Uang')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Jumlah')),
            DropdownButton<String>(
              value: _from,
              items: const ['USD', 'IDR', 'EUR'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => _from = value!),
            ),
            DropdownButton<String>(
              value: _to,
              items: const ['IDR', 'USD', 'EUR'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => _to = value!),
            ),
            ElevatedButton(onPressed: convert, child: const Text('Konversi')),
            const SizedBox(height: 20),
            Text('Hasil: $_result', style: const TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}

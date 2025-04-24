// lib/screens/result_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/zodiac_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Ramalan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<ZodiacProvider>(
        builder: (context, zodiacProvider, child) {
          final zodiac = zodiacProvider.zodiac;

          if (zodiac == null) {
            return const Center(
              child: Text('Data tidak tersedia'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'MBAH JAMBRONG MERAMAL',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bintang anda: ${zodiac.name}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    zodiac.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Menurut bulan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    zodiac.monthPersonality,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'dart:math';
import 'package:flutter/material.dart';

class DailyChallengePage extends StatefulWidget {
  const DailyChallengePage({super.key});

  @override
  State<DailyChallengePage> createState() => _DailyChallengePageState();
}

class _DailyChallengePageState extends State<DailyChallengePage> {
  final List<String> challenges = const [
    "Do 20 squats",
    "Run for 15 minutes",
    "Hold a plank for 1 minute",
    "Do 50 jumping jacks",
  ];

  String currentChallenge = "";

  void generateChallenge() {
    final random = Random();
    setState(() {
      currentChallenge = challenges[random.nextInt(challenges.length)];
    });
  }

  @override
  void initState() {
    super.initState();
    generateChallenge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Challenge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentChallenge, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateChallenge,
              child: const Text('Get New Challenge'),
            )
          ],
        ),
      ),
    );
  }
}

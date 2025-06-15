import 'package:flutter/material.dart';

class GoalProgressPage extends StatefulWidget {
  const GoalProgressPage({super.key});

  @override
  State<GoalProgressPage> createState() => _GoalProgressPageState();
}

class _GoalProgressPageState extends State<GoalProgressPage> {
  final TextEditingController _goalController = TextEditingController();
  final List<Map<String, dynamic>> goals = [
    {'task': 'Walk 20 minutes', 'done': false},
    {'task': 'Drink 8 glasses of water', 'done': false},
    {'task': 'Do 15 squats', 'done': false},
    {'task': 'Stretch 10 mins', 'done': false},
  ];

  final Map<int, int> streakPoints = {}; // weekdayIndex: bonus points
  bool streakAchievedToday = false;

  int get completedGoals => goals.where((g) => g['done']).length;
  int get totalGoals => goals.length;

  void _addGoal() {
    if (_goalController.text.trim().isNotEmpty) {
      setState(() {
        goals.add({'task': _goalController.text.trim(), 'done': false});
        _goalController.clear();
      });
    }
  }

  void _checkStreakTrigger() {
    int today = DateTime.now().weekday % 7;
    if (!streakAchievedToday && completedGoals == totalGoals) {
      setState(() {
        streakPoints[today] = (streakPoints[today] ?? 0) + 10;
        streakAchievedToday = true;
      });
    } else if (completedGoals < totalGoals && streakAchievedToday) {
      // Undo the streak if unchecked
      setState(() {
        streakPoints[today] = (streakPoints[today] ?? 0) - 10;
        streakAchievedToday = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = completedGoals / (totalGoals == 0 ? 1 : totalGoals);
    int today = DateTime.now().weekday % 7;

    return Scaffold(
      appBar: AppBar(title: const Text('Goal Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Today's Fitness Goals",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
            ),
            const SizedBox(height: 20),

            // Goals List
            Expanded(
              child: ListView(
                children: [
                  ...goals.asMap().entries.map((entry) => Card(
                        color: entry.value['done']
                            ? Colors.green[900]
                            : Colors.grey[850],
                        child: CheckboxListTile(
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          activeColor: Colors.orange,
                          title: Text(entry.value['task'],
                              style: const TextStyle(color: Colors.white)),
                          value: entry.value['done'],
                          onChanged: (val) {
                            setState(() => goals[entry.key]['done'] = val);
                            _checkStreakTrigger();
                          },
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _goalController,
                            decoration: const InputDecoration(
                              hintText: 'Add new goal...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _addGoal,
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),
            const Text("Weekly Streak",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                final isToday = index == today;
                final isCompleted = (streakPoints[index] ?? 0) > 0;
                final points = streakPoints[index] ?? 0;
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          isCompleted ? Colors.green : Colors.grey,
                      radius: 18,
                      child: Text(
                        ['S', 'M', 'T', 'W', 'T', 'F', 'S'][index],
                        style: TextStyle(
                          color: isToday ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '+$points',
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                    )
                  ],
                );
              }),
            ),
            const SizedBox(height: 10),
            if (streakAchievedToday)
              const Center(
                child: Text(
                  "🎉 Streak Achieved! +10 Bonus",
                  style: TextStyle(color: Colors.orange, fontSize: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

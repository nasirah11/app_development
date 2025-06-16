import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class WorkoutPlanPage extends StatefulWidget {
  const WorkoutPlanPage({super.key});

  @override
  _WorkoutPlanPageState createState() => _WorkoutPlanPageState();
}

class _WorkoutPlanPageState extends State<WorkoutPlanPage> {
  // Monday workout data aligned with ProfilePage
  static List<Map<String, dynamic>> workouts = [
    {
      "day": "Monday",
      "sessions": [
        {
          "title": "Morning Workout",
          "focus": "Full Body Strength",
          "duration": "45 min",
          "level": "Intermediate",
          "exercises": [
            {"name": "Squats - 3 sets x 15 reps", "completed": false},
            {"name": "Push-ups - 3 sets x 12 reps", "completed": false},
            {"name": "Lunges - 3 sets x 12 reps per leg", "completed": false},
            {"name": "Plank - 3 sets x 1 min", "completed": false},
            {"name": "Deadlifts - 3 sets x 10 reps", "completed": false},
          ],
          "metrics": [9, 6, 7, 8, 5],
          "progress": {"done": 0, "total": 5}
        },
        {
          "title": "Cardio Workout",
          "focus": "Cardio & Endurance",
          "duration": "30 min",
          "level": "Beginner",
          "exercises": [
            {"name": "Jumping Jacks - 3 sets x 20 reps", "completed": true},
            {"name": "High Knees - 3 sets x 15 reps", "completed": true},
            {"name": "Burpees - 3 sets x 10 reps", "completed": false},
            {"name": "Mountain Climbers - 3 sets x 1 min", "completed": false},
            {"name": "Sprint Intervals - 5 sets x 30 sec", "completed": false},
            {"name": "Bicycle Crunches - 3 sets x 20 reps", "completed": false},
          ],
          "metrics": [6, 8, 9, 7, 6],
          "progress": {"done": 2, "total": 6}
        }
      ]
    }
  ];

  // Features for the radar chart
  static const List<String> features = [
    "Strength",
    "Flexibility",
    "Endurance",
    "Intensity",
    "Focus",
  ];

  // Icon for Monday
  IconData _getIcon(String day) {
    switch (day) {
      case "Monday":
        return Icons.fitness_center;
      default:
        return Icons.calendar_today;
    }
  }

  // Update progress with performance optimization
  void _updateProgress(int sessionIndex, int exerciseIndex, bool? value) {
    if (value == null) return; // Guard against null
    setState(() {
      final session = workouts[0]['sessions'][sessionIndex];
      session['exercises'][exerciseIndex]['completed'] = value;
      session['progress']['done'] = session['exercises']
          .where((exercise) => exercise['completed'] == true)
          .length;
      print(
          'Updated progress for ${session['title']}: ${session['progress']['done']}/${session['progress']['total']}');
    });
  }

  @override
  void initState() {
    super.initState();
    print('WorkoutPlanPage initialized with workouts: ${workouts.length}');
  }

  @override
  Widget build(BuildContext context) {
    print('Building WorkoutPlanPage, workouts: ${workouts.length}');
    // Check if workouts list is empty
    if (workouts.isEmpty) {
      print('Workouts list is empty');
      return Scaffold(
        backgroundColor: const Color(0xFF1E1E2C),
        appBar: AppBar(
          title: const Text(
            'Workout Plan',
            style: TextStyle(color: Colors.white),
            semanticsLabel: 'Workout Plan',
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const Center(
          child: Text(
            'No workouts available',
            style: TextStyle(color: Colors.white, fontSize: 18),
            semanticsLabel: 'No workouts available',
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: const Text(
          'Workout Plan',
          style: TextStyle(color: Colors.white),
          semanticsLabel: 'Workout Plan',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final dayWorkout = workouts[index];
          final sessions = dayWorkout['sessions'] as List<Map<String, dynamic>>;
          return Card(
            color: Colors.grey[850],
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Semantics(
                      label: '${dayWorkout['day']} workout icon',
                      child: Icon(
                        _getIcon(dayWorkout['day']),
                        color: Colors.orangeAccent,
                      ),
                    ),
                    title: Text(
                      dayWorkout['day'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      semanticsLabel: dayWorkout['day'],
                    ),
                    subtitle: Text(
                      'Morning & Cardio Sessions',
                      style: const TextStyle(color: Colors.white70),
                      semanticsLabel: 'Morning and Cardio Sessions',
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Render each session
                  ...sessions.asMap().entries.map((entry) {
                    final sessionIndex = entry.key;
                    final session = entry.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          semanticsLabel: session['title'],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Semantics(
                              label: 'Duration',
                              child: const Icon(
                                Icons.schedule,
                                color: Colors.white70,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              session['duration'],
                              style: const TextStyle(color: Colors.white70),
                              semanticsLabel: 'Duration: ${session['duration']}',
                            ),
                            const SizedBox(width: 20),
                            Semantics(
                              label: 'Level',
                              child: const Icon(
                                Icons.bar_chart,
                                color: Colors.white70,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              session['level'],
                              style: const TextStyle(color: Colors.white70),
                              semanticsLabel: 'Level: ${session['level']}',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Exercises: (${session['progress']['done']}/${session['progress']['total']} done)',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              semanticsLabel:
                                  'Exercises: ${session['progress']['done']} of ${session['progress']['total']} done',
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: session['progress']['done'] /
                                    (session['progress']['total'] != 0
                                        ? session['progress']['total']
                                        : 1),
                                backgroundColor: Colors.grey,
                                color: Colors.teal,
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ...List.generate(
                          (session['exercises'] as List).length,
                          (i) {
                            final exercise = session['exercises'][i];
                            return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                exercise['name'],
                                style: TextStyle(
                                  color: Colors.white70,
                                  decoration: exercise['completed']
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              value: exercise['completed'],
                              onChanged: (value) =>
                                  _updateProgress(sessionIndex, i, value),
                              checkColor: Colors.white,
                              activeColor: Colors.teal,
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              secondary: Semantics(
                                label: 'Exercise ${i + 1} checkbox',
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '🏆 ${session['title']} Metrics',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          semanticsLabel: '${session['title']} Metrics',
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: RadarChart.light(
                            ticks: const [2, 4, 6, 8, 10],
                            features: features,
                            data: [List<int>.from(session['metrics'])],
                            reverseAxis: false,
                            useSides: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
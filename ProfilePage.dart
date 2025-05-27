import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white), // White color for app bar title
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 16,
                      child: Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Jamie Nelson',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              'jamienelson12@gmail.com',
              style: TextStyle(color: Colors.white), // White color for email
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.grey[850],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.person, color: Colors.teal),
                        SizedBox(width: 10),
                        Text(
                          "jamieNelson234",
                          style: TextStyle(color: Colors.white), // White color for username
                        ),
                        Spacer(),
                        Icon(Icons.phone, color: Colors.green),
                        SizedBox(width: 10),
                        Text(
                          "+1-8134258374",
                          style: TextStyle(color: Colors.white), // White color for phone number
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              children: const [
                _StatBox(title: '85 Kg', subtitle: 'Current Weight'),
                _StatBox(title: '1/3', subtitle: 'Current Workout'),
                _StatBox(title: 'Apr 01', subtitle: 'Latest Photo'),
                _StatBox(title: 'Sep 05', subtitle: 'Measurement'),
                _StatBox(title: '0', subtitle: 'Steps'),
                _StatBox(title: '120 bpm', subtitle: 'Heart Rate'),
              ],
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Current Workout Plan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            _WorkoutProgress(title: 'Morning Workout', progress: 0.5, done: 0, total: 5),
            const SizedBox(height: 10),
            _WorkoutProgress(title: 'Cardio Workout', progress: 0.33, done: 2, total: 6),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const _StatBox({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), // White color for title
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey), // Subtitle can remain grey or be changed to white
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutProgress extends StatelessWidget {
  final String title;
  final double progress;
  final int done;
  final int total;

  const _WorkoutProgress({required this.title, required this.progress, required this.done, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white), // White color for list tile title
        ),
        subtitle: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey,
          color: Colors.teal,
        ),
        trailing: Text(
          "$done/$total",
          style: TextStyle(color: Colors.white), // White color for list tile trailing text
        ),
      ),
    );
  }
}

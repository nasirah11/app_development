import 'package:flutter/material.dart';
import 'main.dart';  // To return to LoginPage

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Welcome to the Fitness App!',
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final _newUsernameController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Page')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _newUsernameController,
              decoration: InputDecoration(labelText: 'New Username'),
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulate registration
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registered successfully!')),
                );
                Navigator.pop(context);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

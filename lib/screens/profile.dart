import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String username;
  final String mobile;

  const ProfilePage({
    Key? key,
    required this.email,
    required this.username,
    required this.mobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person),
            ),
            const SizedBox(height: 16),
            Text(
              username,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              mobile,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: (){},
                child:const Text('Edit'))
          ],
        ),
      ),
    );
  }
}



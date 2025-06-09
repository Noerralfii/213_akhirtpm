import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/user.png')),
            SizedBox(height: 20),
            Text('Nama Pengguna', style: TextStyle(fontSize: 20)),
            Text('Email Pengguna', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

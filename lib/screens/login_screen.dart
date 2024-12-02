import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Hoşgeldiniz!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'E-posta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Giriş yap butonuna basıldığında
                Navigator.pushReplacementNamed(context, '/map'); // MapScreen'e yönlendirme
              },
              child: const Text('Giriş Yap'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Şifremi Unuttum
                // Daha sonra bu route'u ekleyeceğiz
              },
              child: const Text('Şifremi Unuttum'),
            ),
          ],
        ),
      ),
    );
  }
}
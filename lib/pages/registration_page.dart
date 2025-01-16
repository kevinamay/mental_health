import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Controller untuk masing-masing input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController npmController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fakultasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Registrasi Pengguna"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: npmController,
              decoration: InputDecoration(labelText: "NPM"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            TextField(
              controller: fakultasController,
              decoration: InputDecoration(labelText: "Fakultas"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                registerUser(context);  // Memanggil fungsi register
              },
              child: Text("Sign Up"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Warna tombol
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk melakukan registrasi pengguna
  void registerUser(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      // Membuat user baru dengan email dan password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Menyimpan data pengguna ke Firebase Realtime Database
      final user = userCredential.user;
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user?.uid}");
      await ref.set({
        "name": nameController.text,
        "npm": npmController.text,
        "email": email,
        "fakultas": fakultasController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registrasi Berhasil!"),
      ));

      // Arahkan pengguna ke halaman login setelah registrasi berhasil
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? "Terjadi kesalahan"),
      ));
    }
  }
}


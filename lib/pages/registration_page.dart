import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lottie/lottie.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, color: Colors.black),
            SizedBox(width: 8),
            Text(
              "REGISTRASI",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image placeholder (replace with your asset path)
              Lottie.asset(
                'assets/animasi.json', // Ganti dengan path gambar Anda
                width: 600,
                height: 600,
              ),
              SizedBox(height: 20),
              // Form Fields
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    // Name Field
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    // NPM Field
                    TextField(
                      controller: npmController,
                      decoration: InputDecoration(
                        labelText: 'NPM',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Email Field
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Password Field
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Fakultas Field
                    TextField(
                      controller: fakultasController,
                      decoration: InputDecoration(
                        labelText: 'Fakultas',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        registerUser(context); // Memanggil fungsi register
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Background color
                        foregroundColor: Colors.black, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize:
                            Size(double.infinity, 50), // Full-width button
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("users/${user?.uid}");
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

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Controller untuk input data
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
            // Input untuk Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            // Input untuk NPM
            TextField(
              controller: npmController,
              decoration: InputDecoration(labelText: "NPM"),
            ),
            // Input untuk Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            // Input untuk Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            // Input untuk Fakultas
            TextField(
              controller: fakultasController,
              decoration: InputDecoration(labelText: "Fakultas"),
            ),
            SizedBox(height: 20),
            // Tombol Sign Up
            ElevatedButton(
              onPressed: () {
                registerUser(context); // Memanggil fungsi register
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

  // Fungsi untuk melakukan registrasi dan menyimpan data ke Firebase
  void registerUser(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      // Membuat user baru dengan email dan password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user != null) {
        // Periksa UID
        print("UID Pengguna: ${user.uid}");

        // Menyimpan data pengguna ke Firebase Realtime Database
        DatabaseReference ref =
            FirebaseDatabase.instance.ref("users/${user.uid}");

        // Menyimpan data ke Firebase Realtime Database
        print("Menyimpan data ke Firebase...");
        await ref.set({
          "name": nameController.text,
          "npm": npmController.text,
          "email": email,
          "fakultas": fakultasController.text,
        }).then((_) {
          print("Data berhasil disimpan!");
        }).catchError((error) {
          print("Error saat menyimpan data: $error");
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Registrasi Berhasil!"),
        ));

        // Arahkan pengguna ke halaman login setelah registrasi berhasil
        Navigator.pushReplacementNamed(context, '/login');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? "Terjadi kesalahan"),
      ));
    }
  }
}

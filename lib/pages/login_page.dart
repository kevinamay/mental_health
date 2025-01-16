import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';  // Menambahkan impor Lottie


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk input email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animasi atau Logo jika ada
            SizedBox(
              width: 600,
              height: 600,
              child: Lottie.asset('assets/login.json'),
            ),
            SizedBox(height: 20),
            
            // Kotak Login
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // TextField untuk email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),

                  // TextField untuk password
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Tombol LOGIN
                  ElevatedButton(
                    onPressed: () {
                      loginUser(context);  // Memanggil fungsi login
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Teks untuk registrasi
                  Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register'); // Pindah ke halaman registrasi
                    },
                    child: Text(
                      "Create an account",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk melakukan login
  void loginUser(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      // Login pengguna menggunakan email dan password
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Jika login berhasil, arahkan ke halaman SRQ
      Navigator.pushReplacementNamed(context, '/srq'); // Arahkan ke halaman berikutnya
    } on FirebaseAuthException catch (e) {
      // Jika login gagal, tampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? "Login gagal"),
      ));
    }
  }
}

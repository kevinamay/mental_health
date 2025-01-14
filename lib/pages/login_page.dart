import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Latar belakang putih untuk keseluruhan layar
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animasi Lottie
            SizedBox(
              width: 600, // Lebar animasi
              height: 600, // Tinggi animasi
              child: Lottie.asset(
                'assets/login.json',
              ),
            ),
            SizedBox(height: 20),
            // Kotak Login
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange, // Warna latar oranye
                borderRadius: BorderRadius.circular(20), // Sudut membulat
              ),
              child: Column(
                children: [
                  // TextField Email
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person,
                          color: Colors.black), // Ikon pengguna
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black), // Warna label
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor:
                          Colors.white, // Latar belakang putih untuk input
                    ),
                  ),
                  SizedBox(height: 10),
                  // TextField Password
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.lock, color: Colors.black), // Ikon kunci
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black), // Warna label
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor:
                          Colors.white, // Latar belakang putih untuk input
                    ),
                  ),
                  SizedBox(height: 20),
                  // Tombol LOGIN
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/srq');
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.black, // Teks hitam
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Latar belakang putih
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Sudut membulat
                        side: BorderSide(color: Colors.black), // Border hitam
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Teks untuk registrasi
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
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
}

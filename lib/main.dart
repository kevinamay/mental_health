import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import Firebase configuration
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'pages/login_page.dart';
import 'pages/registration_page.dart';
import 'pages/srq_question_page.dart';
import 'pages/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi Firebase dengan opsi yang sesuai dengan platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Self Reporting Questionnaire',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/login', // Halaman pertama yang ditampilkan
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/srq': (context) => SRQQuestionPage(),
        '/chat': (context) => ChatPage(),
      },
    );
  }
}

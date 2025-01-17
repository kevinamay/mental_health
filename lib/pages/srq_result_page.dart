import 'package:flutter/material.dart';

class SRQResultPage extends StatelessWidget {
  final int yesCount;

  SRQResultPage({required this.yesCount});

  @override
  Widget build(BuildContext context) {
    // Menentukan status gangguan mental berdasarkan jumlah jawaban "YA"
    String mentalHealthStatus = yesCount >= 6
        ? 'Kamu mungkin mengalami gangguan mental emosional atau distres yang berpotensi pada gangguan jiwa.'
        : 'Kamu tidak mengalami gangguan mental emosional atau distres yang berpotensi pada gangguan jiwa.';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hasil SRQ-20',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nilai Self Reporting Questionnaire (SRQ-20) kamu adalah $yesCount',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Menampilkan status mental berdasarkan hasil
            Text(
              mentalHealthStatus,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 30),
            // Tampilkan tombol sesuai dengan kondisi
            yesCount >= 10
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                    child: Text(
                      'LANJUT KONSULTASI',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

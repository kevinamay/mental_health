import 'package:flutter/material.dart';
import 'srq_result_page.dart';

class SRQQuestionPage extends StatefulWidget {
  @override
  _SRQQuestionPageState createState() => _SRQQuestionPageState();
}

class _SRQQuestionPageState extends State<SRQQuestionPage> {
  final List<String> questions = [
    'Apakah saudara merasa sakit kepala?',
    'Apakah nafsu makan saudara menurun?',
    'Apakah saudara tidak bisa tidur dengan nyenyak?',
    'Apakah saudara mudah merasa takut?',
    'Apakah tangan saudara gemetar?',
    'Apakah saudara merasa cemas, tegang, atau khawatir?',
    'Apakah saudara mengalami masalah pencernaan?',
    'Apakah saudara mengalami kesulitan untuk berpikir jernih?',
    'Apakah anda merasa tidak bahagia?',
    'Lebih banyak menangis dari biasanya',
    'Saudara sulit menikmati kegiatan sehari-hari',
    'Kesulitan mengambil keputusan',
    'Mengalami penurunan kinerja',
    'Merasa tidak bisa melakukan hal yang bermanfaat dalam hidup',
    'Merasa kehilangan minat untuk melakukan berbagai hal?',
    'Merasa tidak berguna',
    'Ada pemikiran untuk mengakhiri hidup',
    'Apakah saudara merasa lelah sepanjang waktu?',
    'Apakah perut saudara kerap terasa tidak nyaman?',
    'Mudah merasa lelah'
  ];

  int currentQuestionIndex = 0; // Indeks pertanyaan saat ini
  Map<int, String> answers = {}; // Jawaban disimpan di Map

  void _recordAnswer(String answer) {
    setState(() {
      answers[currentQuestionIndex] = answer;
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Hitung jumlah jawaban "YA"
      int yesCount = answers.values.where((answer) => answer == 'YA').length;

      // Navigasi ke halaman hasil dengan nilai "yesCount"
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SRQResultPage(yesCount: yesCount),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Icon(Icons.person, color: Colors.black),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ANGELINA',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '52204123',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login'); // Logout
            },
            child: Text(
              'LOGOUT',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'SELF REPORTING QUESTIONNAIRE\n(SRQ-20)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                questions[currentQuestionIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _recordAnswer('YA'),
                  child: Text('YA',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _recordAnswer('TIDAK'),
                  child: Text('TIDAK',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (answers.containsKey(currentQuestionIndex)) {
                      _nextQuestion();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Pilih jawaban terlebih dahulu!')),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        'NEXT',
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

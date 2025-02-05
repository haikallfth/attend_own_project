import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Bagian atas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/ppAbsen.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Haikal Al Fatih",
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(
                        "icalderr00@gmail.com",
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.candlestick_chart,
                      size: 30,
                    ),
                    SizedBox(width: 15),
                    Icon(
                      Icons.settings_sharp,
                      size: 27,
                    )
                  ],
                )
              ],
            ),
          ),
          // Animasi Lottie
          const SizedBox(height: 70), // Jarak dari header
          SizedBox(
            width: 350,
            height: 350,
            child: Lottie.asset(
              'assets/animation/attendance_animation.json',
              fit: BoxFit.contain,
            ),
          ),
          // Teks di bawah
          const SizedBox(height: 20), // Jarak antara animasi dan teks
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Attendance\n',
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                    fontSize: 40,
                    color: Color(0xff7BD3EA),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: const [
                  TextSpan(
                    text: 'App Design\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

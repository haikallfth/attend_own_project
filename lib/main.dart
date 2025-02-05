import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:own_absensi_app/screen/profile_page.dart';
import 'package:own_absensi_app/screen/ui/attend/attend_screen.dart';
import 'screen/home_page.dart';
import 'screen/profile_page.dart';
import 'screen/attendance_app_nya.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDl-2r7m39PTrm_CnjUDX2x-RqkFCn8R7o',
          appId: '1:208956292881:android:ad0b2530fd81e34c4f56b0',
          messagingSenderId: '208956292881',
          projectId: 'absensi-8d5fe'
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    AttendanceAppPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xff7BD3EA), // Ganti warna sesuai keinginan
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), // Hanya kiri atas
            topRight: Radius.circular(30), // Hanya kanan atas
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5), // Posisi bayangan
            ),
          ],
        ),
        width: double.infinity, // Lebar penuh
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: SalomonBottomBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              SalomonBottomBarItem(
                icon: const Icon(
                  Icons.home_rounded,
                  color: Color(0xffF1FAFF),
                  size: 30,
                ),
                title: Text(
                  "Home",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                      color: Color(0xffF1FAFF),
                    ),
                  ),
                ),
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: const Icon(
                  Icons.edit_calendar_rounded,
                  color: Color(0xffF1FAFF),
                  size: 30,
                ),
                title: Text(
                  "Attendance",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                      color: Color(0xffF1FAFF),
                    ),
                  ),
                ),
              ),
              SalomonBottomBarItem(
                icon: const Icon(
                  Icons.person,
                  size: 30,
                  color: Color(0xffF1FAFF),
                ),
                title: Text(
                  "Profile",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                      color: Color(0xffF1FAFF),
                    ),
                  ),
                ),
                selectedColor: Colors.white,
              ),
            ],
          ),
        ),
      ),

    );
  }
}

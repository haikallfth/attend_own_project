
import 'package:flutter/material.dart';
import 'package:own_absensi_app/screen/ui/absen/absen_screen.dart';
import 'package:own_absensi_app/screen/ui/attend/attend_screen.dart';
import 'package:own_absensi_app/screen/ui/attendance_history/attendance_history_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceAppPage extends StatelessWidget {
  const AttendanceAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false, //mengunci tombol back perangkat
        onPopInvoked: (bool didPop){
          if(didPop){
            return;
          }
          _onWillPop(context);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendScreen()));
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(30),
                                  width: 200,
                                  height: 200,
                                  child: Image(image: AssetImage('assets/images/logo_cuti_izin.png')),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.deepPurpleAccent,
                                      width: 3
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  )
                                ),
                                SizedBox(height: 10,),
                                Text('Absen Kehadiran', style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),)
                              ],
                            )
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child:  InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AbsenScreen()));
                            },
                            child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(30),
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.deepPurpleAccent,
                                          width: 3
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Image(image: AssetImage('assets/images/logo_absent.png')),
                                ),
                                SizedBox(height: 10,),
                                Text('Cuti / Izin', style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),)
                              ],
                            )
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceHistoryScreen()));
                            },
                            child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(30),
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.deepPurpleAccent,
                                          width: 3
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Image(image: AssetImage('assets/images/logo_attendance_history.png')),
                                ),
                                SizedBox(height: 10,),
                                Text('Riwayat Kehadiran', style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),)
                              ],
                            )
                        ),
                      ),
                    ],
                  )
              )
          ),
        )
    );
  }
}

Future<bool> _onWillPop(BuildContext context) async{
  return (await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("INFO"),
        content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Keluar"),
          )
        ],
      )
  )
  ) ?? false; //jika dialog ditutup tanpa aksi, maka kembalikan nilai false
}
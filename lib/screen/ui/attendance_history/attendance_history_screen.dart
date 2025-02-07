import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff7BD3EA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Attendence History", style: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        )),
      ),
      body: FutureBuilder <QuerySnapshot>(
          future: dataCollection.get(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var data = snapshot.data!.docs;
              return data.isNotEmpty ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text((data.isNotEmpty && data[index]['name'] != null)
                              ? data[index]['name'][0].toUpperCase()
                              : '-',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text('name', style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),),
                                    ),
                                    Expanded(
                                      child: Text(':', style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14
                                        ),
                                      )),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Text(data[index]['name'],
                                          style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ))
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text('address le', style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      )),
                                    ),
                                    Expanded(
                                      child: Text(':', style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14
                                        ),
                                      )),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Text(data[index]['address'],
                                          style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ))
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text('Status lek', style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      )),
                                    ),
                                    Expanded(
                                      child: Text(':', style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14
                                        ),
                                      )),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Text(data[index]['status'],
                                          style: GoogleFonts.plusJakartaSans(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text('dateTime', style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      )),
                                    ),
                                    Expanded(
                                      child: Text(':', style: GoogleFonts.plusJakartaSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14
                                        ),
                                      )),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Text(data[index]['dateTime'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),)
                                    ),
                                  ],
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  );
                }
              )
              :Center(
                child: Text("Eitss, data gaada lek", style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                )),
              );
            }
            else{
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff7BD3EA)),
                ),
              );
            }
          }
      ),
    );
  }
}

import 'package:own_absensi_app/screen/ui/attend/attend_screen.dart';
// import 'package:own_absensi_app/ui/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';


class AbsenScreen extends StatefulWidget {
  const AbsenScreen({super.key});

  @override
  State<AbsenScreen> createState() => _AbsenScreenState();
}

class _AbsenScreenState extends State<AbsenScreen> {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');
  final controllerName = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  String dropValueCategories = "Pilih le:";
  var categoriesList = <String>["Pilih le:", "purkit", "ambil cuti ge", "nugas", "apa be lah"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff7BD3EA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Request izin le",
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(10,10,10,30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xff7BD3EA),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                ),
                child: Row(
                  children: [
                    SizedBox(width: 12,),
                    Icon(Icons.maps_home_work_outlined, color: Color(0xffF1FAEE),),
                    SizedBox(width: 12,),
                    Text("le le ayolah isi formnya le", style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    )
                    ),

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10,20,10,20),
                child: TextField(
                  controller: controllerName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Nama lu le",
                    labelStyle: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14
                      ),
                    ),
                    hintText: "Field your name bro",
                    hintStyle: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xff7BD3EA),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.lightBlueAccent
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Deskripsi",
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7BD3EA)
                      ),
                    )
                  ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xff7BD3EA),
                      width: 1.0
                    ),
                  ),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    value: dropValueCategories,
                    items: categoriesList.map((value){
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.toString(),
                          style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(fontSize: 14, color: Colors.black)
                          ),
                        ),
                        );
                      }).toList(),
                    onChanged: (value){
                      setState(() {
                        dropValueCategories = value.toString();
                      });
                      },
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    underline: Container(
                      color: Colors.transparent,
                        height: 2,
                    ),
                    isExpanded: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                          children: [
                            Text("From: ", style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff7BD3EA),
                              ),
                            )),
                            Expanded(
                                child: TextField(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        builder: (BuildContext context, Widget? child){
                                          return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: const ColorScheme.light(
                                                  onPrimary: Colors.white,
                                                  onSurface: Colors.white,
                                                  primary: Color(0xff7BD3EA)
                                                ),
                                                datePickerTheme: const DatePickerThemeData(
                                                  headerBackgroundColor: Color(0xff7BD3EA),
                                                  backgroundColor: Colors.white,
                                                )
                                              ),
                                              child: child!
                                          );
                                        },
                                        context: context,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(9999),
                                    );
                                    if(pickedDate != null){
                                      fromController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                                    }
                                  },
                                  style: GoogleFonts.plusJakartaSans(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff7BD3EA)
                                    ),
                                  ),
                                  controller: fromController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    hintText: "Starting from",
                                    hintStyle: GoogleFonts.plusJakartaSans(
                                      textStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16
                                      ),
                                    )
                                  ),
                                ),
                            ),
                            Expanded(
                                child: Row(
                                  children: [
                                    Text("Until: ", style: GoogleFonts.plusJakartaSans(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff7BD3EA)
                                      ),
                                    )),
                                    Expanded(
                                        child: TextField(
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              builder: (BuildContext context, Widget? child){
                                                return Theme(
                                                    data: Theme.of(context).copyWith(
                                                        colorScheme: const ColorScheme.light(
                                                            onPrimary: Colors.white,
                                                            onSurface: Colors.white,
                                                            primary: Color(0xff7BD3EA)
                                                        ),
                                                        datePickerTheme: const DatePickerThemeData(
                                                          headerBackgroundColor: Color(0xff7BD3EA),
                                                          backgroundColor: Colors.white,
                                                        )
                                                    ),
                                                    child: child!
                                                );
                                              },
                                              context: context,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(9999),
                                            );
                                            if(pickedDate != null){
                                              toController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                                            }
                                          },
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                          controller: toController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(8),
                                            hintText: "Until",
                                            hintStyle: GoogleFonts.plusJakartaSans(
                                              textStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16
                                              ),
                                            )
                                          ),
                                        ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(30),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 50,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff7BD3EA),
                      child: InkWell(
                        splashColor: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          if(controllerName.text.isEmpty || dropValueCategories == "Pilih le:" || fromController.text.isEmpty || toController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.info_outline, color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Text("EItss, plis lah le isi form nya", style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(color: Colors.white)),),
                                ],
                              ),
                              backgroundColor: Color(0xff7BD3EA),
                              shape: StadiumBorder(),
                              behavior: SnackBarBehavior.floating,
                            ));
                          }
                          else{
                            submitAbsen(controllerName.text.toString(), dropValueCategories.toString(), fromController.text, toController.text);
                          }
                        },
                        child: Center(
                          child: Text("Buat request le", style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(
                                color: Colors.white
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> submitAbsen(String name, String reason, String from, String until)async{
    showLoaderDialog(context);
    dataCollection.add({
      'address': '-',
      'name': name,
      'status': reason,
      'dateTime': '$from-$until'
    }).then((result) {
      setState(() {
        Navigator.of(context).pop();
        try {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Text(
                        "Data lu dah ke submit le",
                        style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(color: Colors.white)),
                      ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const AttendScreen()));
        }
        catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.error_outline_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "eitss ada yang error le, coba ge nanti der",
                      style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    });
  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text("Checking the data...", style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(color: Colors.white)),),
          )
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );
  }
}

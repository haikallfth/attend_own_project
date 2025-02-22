import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'camera.dart';

class AttendScreen extends StatefulWidget {
  final XFile? image;
  const AttendScreen({super.key, this.image});

  @override
  State<AttendScreen> createState() => _AttendScreenState();
}

class _AttendScreenState extends State<AttendScreen> {
  String strDate = "", strTime = "", strDateTime = "", strStatus = "Attend", strAddress = "";
  double dLat = 0, dLong = 0;
  int dateHours = 0, dateMinutes = 0;
  bool isLoading = false;
  XFile? image;
  final controllerName = TextEditingController();
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('absensi');
  @override
  void initState(){
    getGeolocationPosition();
    handleLocationPermission();
    setDateTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff7BD3EA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Attendance Menu",
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Color(0xff7BD3EA),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(Icons.face_retouching_natural_outlined, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      "Please make a selfie photo!",
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: Text(
                  "Capture Photo",
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff7BD3EA))
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CameraScreen()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: size.width,
                  height: 150,
                  child: DottedBorder(
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    color: Color(0xff7BD3EA),
                    strokeWidth: 1,
                    dashPattern: const [5, 5],
                    child: SizedBox.expand(
                      child: FittedBox(
                        child: image != null
                          ? Image.file(File(image!.path), fit: BoxFit.cover,)
                          :const Icon(
                            Icons.camera_enhance_outlined,
                            color: Color(0xff7BD3EA),
                          ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  controller: controllerName,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Your Name",
                    hintText: "Please enter your name",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: GoogleFonts.plusJakartaSans().fontFamily),
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black, fontFamily: GoogleFonts.plusJakartaSans().fontFamily),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xff7BD3EA)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xff7BD3EA)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  "Your Location",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff7BD3EA))
                  ),
                ),
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xff7BD3EA)),)
                  : Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(height: 120,
                        child: TextField(
                          enabled: false,
                          maxLines: 5,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xff7BD3EA)),
                            ),
                            hintText: strAddress.isNotEmpty ? strAddress : 'Your Location',
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                            fillColor: Colors.transparent,
                            filled: true,
                          ),
                        )
                      ),
                    ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(30),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: size.width,
                    height: 50,
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
                          if(image == null || controllerName.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "oitt lee isi form nya dulu lee",
                                        style: GoogleFonts.plusJakartaSans(
                                          textStyle: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                backgroundColor: Colors.blueGrey,
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                          else{
                            submitAbsen(strAddress, controllerName.text.toString(), strStatus);
                          }
                        },
                        child: Center(
                          child: Text(
                            "Report Now",
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> handleLocationPermission() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Row(
            children: [
              Icon(
                Icons.location_off,
                color: Colors.white,
              ),
              SizedBox(width: 10,),
              Text(
                "Please enable location service",
                style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(color: Colors.white)
                ),
              ),
            ],
          ),
            backgroundColor: Colors.blueGrey,
            shape: StadiumBorder(),
            behavior: SnackBarBehavior.floating,
          ));
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Row(
              children: [
                Icon(
                  Icons.location_off,
                  color: Colors.white,
                ),
                SizedBox(width: 10,),
                Text(
                  "Location permission are denied. Please enable location service",
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ],
            ),
              backgroundColor: Colors.blueGrey,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
            ));
      }
    }
    if (permission == LocationPermission.deniedForever){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Row(
            children: [
              Icon(
                Icons.location_off,
                color: Colors.white,
              ),
              SizedBox(width: 10,),
              Text(
                "Location permission are denied forever. Please enable location service",
                style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(color: Colors.white)
                ),
              ),
            ],
          ),
            backgroundColor: Colors.blueGrey,
            shape: StadiumBorder(),
            behavior: SnackBarBehavior.floating,
          ));
      return false;
    }
    return true;
  }
  Future<void> getGeolocationPosition() async{
    // ignore: deprecated_member_use
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    setState(() {
      isLoading = false;
      getAddressFromLongLat(position);
    });
  }
  Future<void> getAddressFromLongLat(Position position)async{
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      dLat = position.latitude;
      dLong = position.longitude;
      strAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }
  void setDateTime() async {
    var dateNow = DateTime.now();
    var dateFormat = DateFormat('dd MMMM YYYY');
    var dateTime = DateFormat('HH:mm:ss');
    var dateHour = DateFormat('HH');
    var dateMinute = DateFormat('mm');

    setState(() {
      strDate = dateFormat.format(dateNow);
      strTime = dateTime.format(dateNow);
      strDateTime = "$strDate | $strTime";

      dateHours = int.parse(dateHour.format(dateNow));
      dateMinutes = int.parse(dateMinute.format(dateNow));
    });
  }
  void setStatusAbsen(){
    if(dateHours < 8 || (dateHours == 8 && dateMinutes <= 30)){
      strStatus = 'Hadir';
    }else if((dateHours > 8 && dateHours < 18)||(dateHours == 8 && dateMinutes >= 31)){
      strStatus = 'terlambat';
    }else{
      strStatus = 'tidak hadir';
    }
  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child:  Text("Checking the data...", style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(color: Colors.white)),),
          )
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
  Future<void> submitAbsen(String address, String name, String status) async {
    showLoaderDialog(context);
    dataCollection.add({
      'address': address,
      'name': name,
      'status': status,
      'date': strDate,
      'time': strTime
    }).then((result) {
      setState(() {
        try {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Absen Berhasil",
                    style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(color: Colors.white)),
                  )
                ],
              ),
              backgroundColor: Colors.green,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AttendScreen()));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Absen Gagal",
                    style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(color: Colors.white)),
                  )
                ],
              ),
              backgroundColor: Colors.red,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Absen Gagal",
                style: GoogleFonts.plusJakartaSans(textStyle: TextStyle(color: Colors.white)),
              )
            ],
          ),
          backgroundColor: Colors.red,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

}


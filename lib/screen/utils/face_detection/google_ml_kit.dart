
// GoogleMlKit ini berfungsi menyimpan vision biar teratur dan gampang ke manage
import 'package:own_absensi_app/screen/utils/face_detection/vision.dart';

class GoogleMlKit{
  GoogleMlKit._();

  // mengambil kelas vision
  static final Vision vision = Vision.instance;
}
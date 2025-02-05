import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class Vision {
  // ._() = ini adalah Constructor private ( jadi khusus wajah doang )
  Vision._();

  // ini berfungsi agar Constructor private nya bisa di panggil di kelas lain
  static final Vision instance = Vision._();

  // face detector options berfungsi untuk membuat pengaturan khusus wajah, dan membuat pengaturan yang sama dengan FaceDetectorOptions()
  FaceDetector faceDetector([FaceDetectorOptions? options]) {
    return FaceDetector(options: options ?? FaceDetectorOptions());
  }
}
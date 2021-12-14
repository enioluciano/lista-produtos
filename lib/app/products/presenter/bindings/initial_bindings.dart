import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:project_test/app/products/presenter/controllers/initial_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    Get.put<FirebaseFirestore>(db, permanent: true);
    Get.put<FirebaseStorage>(storage, permanent: true);
    Get.put(InitialController());
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_test/app/routes/app_routes.dart';
import 'package:project_test/app/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await addItem();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Project Test',
        initialRoute: Routes.HOME,
        getPages: RoutesPages.routes);
  }
}

Future<void> addItem() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String data = await rootBundle.loadString('assets/json/products.json');
  final jsonResult = jsonDecode(data);

  for (var product in jsonResult) {
    CollectionReference itemId = db.collection("products");
    product['id'] = itemId.doc().id;

    File file = await getImageFileFromAssets(product['filename']);
    await uploadImagesBd(file, product);
  }
}

Future uploadImagesBd(File fileImage, Map<String, dynamic> product) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference pastaRaiz = storage.ref();
  // String nomeUnico;

  String nameSingle = DateTime.now().millisecondsSinceEpoch.toString();
  Reference arquivo =
      pastaRaiz.child("fotos").child(product['id']).child("$nameSingle.png");

  UploadTask task = arquivo.putFile(fileImage);
  task.then((TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    product['url'] = url;
    product['singleName'] = nameSingle;
    product['updateTime'] = DateTime.now().microsecondsSinceEpoch;
    saveData(product);
    print('Upload complete!');
  }).catchError((error) {
    print(error.toString()); // FirebaseException
  });
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/images/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future<void> saveData(Map<String, dynamic> product) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  await db.collection('products').doc(product['id']).set(product);
}

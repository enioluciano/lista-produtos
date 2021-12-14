import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_test/app/products/infra/datasources/products_datasource.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';

class ProductsDataSourceImpl implements ProductsDataSource {
  FirebaseFirestore db;
  FirebaseStorage storage;
  ProductsDataSourceImpl({required this.db, required this.storage});
  @override
  Future<List<Map<String, dynamic>>> getListProducts() async {
    try {
      QuerySnapshot querySnapshot = await db.collection('products').get();
      List<Map<String, dynamic>> products = [];

      for (DocumentSnapshot product in querySnapshot.docs) {
        Map<String, dynamic> response = product.data() as Map<String, dynamic>;
        products.add(response);
      }
      return products;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(ProductModel product) async {
    try {
      await db.collection('products').doc(product.id).delete();
      await storage
          .ref()
          .child('fotos')
          .child(product.id!)
          .child('${product.singleName}.png')
          .delete();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> editProduct(ProductModel product) async {
    try {
      await db.collection('products').doc(product.id).update(product.toJson());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> getUrlDownlodStorage(ProductModel product) async {
    try {
      Reference ref = storage
          .ref()
          .child('fotos')
          .child(product.id!)
          .child('${product.singleName}.png');

      String url = await ref.getDownloadURL();

      DateTime date = DateTime.now();

      var tempDir = await getTemporaryDirectory();
      String fullPath =
          tempDir.path + "avatar${date.millisecondsSinceEpoch}.png";

      Response response = await Dio().get(url,
          // onReceiveProgress: showDownloadProgress,
          //Received data with List<int>
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 400;
              }));

      File file = File(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      return raf.path;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> uploadImageStorage(
      ProductModel product, String imagePath) async {
    Reference rootFolder = storage.ref();

    String nameSingle = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      Reference archive =
          rootFolder.child("fotos").child(product.id!).child("$nameSingle.png");
      if (imagePath != '') {
        File file = File(imagePath);
        UploadTask task = archive.putFile(file);
        await task.then((TaskSnapshot snapshot) async {
          String url = await snapshot.ref.getDownloadURL();
          product.url = url;
          product.singleName = nameSingle;
          print('Upload complete!');
          editProduct(product);
        }).catchError((error) {
          print(error.toString()); // FirebaseException
        });
      } else {
        await editProduct(product);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:project_test/app/products/data/datasource/remote/products_datasource_impl.dart';
import 'package:project_test/app/products/domain/infra/products_repository.dart';
import 'package:project_test/app/products/domain/usecases/delete_product_usecase._impl.dart';
import 'package:project_test/app/products/domain/usecases/get_products_usecase_impl.dart';
import 'package:project_test/app/products/infra/datasources/products_datasource.dart';
import 'package:project_test/app/products/infra/repository/products_repository_impl.dart';
import 'package:project_test/app/products/presenter/usecases/products_usecase.dart';
import '../controllers/home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ProductsDataSource>(ProductsDataSourceImpl(
        db: Get.find<FirebaseFirestore>(),
        storage: Get.find<FirebaseStorage>()));
    Get.put<ProductsRepository>(ProductsRepositoryImpl(
        productsDataSource: Get.find<ProductsDataSource>()));

    Get.put<GetProducts>(
        GetProductsImpl(productsRepository: Get.find<ProductsRepository>()));
    Get.put<DeleteProduct>(
        DeleteProductImpl(productsRepository: Get.find<ProductsRepository>()));
    Get.put(HomeController());
  }
}

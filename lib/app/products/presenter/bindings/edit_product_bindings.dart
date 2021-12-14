import 'package:get/get.dart';
import 'package:project_test/app/products/domain/infra/products_repository.dart';
import 'package:project_test/app/products/domain/usecases/edit_product_usecase_impl.dart';
import 'package:project_test/app/products/domain/usecases/upload_image_storage_usecase_impl.dart';
import 'package:project_test/app/products/domain/usecases/url_download_storage_usecase_impl.dart';
import 'package:project_test/app/products/presenter/usecases/products_usecase.dart';
import '../controllers/edit_product_controller.dart';

class EditProductBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<EditProduct>(
        EditProductImpl(productsRepository: Get.find<ProductsRepository>()));
    Get.put<GetUrlDownloadStorage>(GetUrlDownloadStorageImpl(
        productsRepository: Get.find<ProductsRepository>()));
    Get.put<UploadImageStorage>(UploadImageStorageImpl(
        productsRepository: Get.find<ProductsRepository>()));
    Get.put(EditProductController());
  }
}

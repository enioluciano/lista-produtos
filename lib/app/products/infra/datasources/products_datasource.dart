import 'package:project_test/app/products/infra/models/products_model.dart';

abstract class ProductsDataSource {
  Future<List<Map<String, dynamic>>> getListProducts();
  Future<void> deleteProduct(ProductModel product);
  Future<void> editProduct(ProductModel product);
  Future<String> getUrlDownlodStorage(ProductModel product);
  Future<void> uploadImageStorage(ProductModel product, String imagePath);
}

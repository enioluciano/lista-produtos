import 'package:project_test/app/products/infra/models/products_model.dart';

abstract class GetProducts {
  Future<List<ProductModel>> call();
}

abstract class DeleteProduct {
  Future<void> call(ProductModel product);
}

abstract class EditProduct {
  Future<void> call(ProductModel product);
}

abstract class GetUrlDownloadStorage {
  Future<String> call(ProductModel product);
}

abstract class UploadImageStorage {
  Future<void> call(ProductModel product, String imagePath);
}

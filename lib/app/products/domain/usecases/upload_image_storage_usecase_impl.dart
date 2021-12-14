import 'package:project_test/app/products/domain/infra/products_repository.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';
import 'package:project_test/app/products/presenter/usecases/products_usecase.dart';

class UploadImageStorageImpl implements UploadImageStorage {
  ProductsRepository productsRepository;
  UploadImageStorageImpl({required this.productsRepository});
  @override
  Future<void> call(ProductModel product, String imagePath) async {
    await productsRepository.uploadImageStorage(product, imagePath);
  }
}

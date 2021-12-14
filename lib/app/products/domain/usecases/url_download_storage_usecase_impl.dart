import 'package:project_test/app/products/domain/infra/products_repository.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';
import 'package:project_test/app/products/presenter/usecases/products_usecase.dart';

class GetUrlDownloadStorageImpl implements GetUrlDownloadStorage {
  ProductsRepository productsRepository;
  GetUrlDownloadStorageImpl({required this.productsRepository});
  @override
  Future<String> call(ProductModel product) async {
    final data = await productsRepository.getUrlDownlodStorage(product);
    return data;
  }
}

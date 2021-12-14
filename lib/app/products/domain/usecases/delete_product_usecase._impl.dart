import 'package:project_test/app/products/domain/infra/products_repository.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';
import 'package:project_test/app/products/presenter/usecases/products_usecase.dart';

class DeleteProductImpl implements DeleteProduct {
  ProductsRepository productsRepository;
  DeleteProductImpl({required this.productsRepository});
  @override
  Future<void> call(ProductModel product) async {
    await productsRepository.deleteProduct(product);
  }
}

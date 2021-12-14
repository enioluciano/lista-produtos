import 'package:project_test/app/products/domain/infra/products_repository.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';
import 'package:project_test/app/products/presenter/usecases/products_usecase.dart';

class EditProductImpl implements EditProduct {
  ProductsRepository productsRepository;
  EditProductImpl({required this.productsRepository});
  @override
  Future<void> call(ProductModel product) async {
    await productsRepository.editProduct(product);
  }
}

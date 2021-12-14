import 'package:project_test/app/products/domain/infra/products_repository.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';
import 'package:project_test/app/products/presenter/usecases/products_usecase.dart';

class GetProductsImpl implements GetProducts {
  ProductsRepository productsRepository;
  GetProductsImpl({required this.productsRepository});
  @override
  Future<List<ProductModel>> call() async {
    final data = await productsRepository.getListProducts();

    return data;
  }
}

import 'package:project_test/app/products/domain/infra/products_repository.dart';
import 'package:project_test/app/products/infra/datasources/products_datasource.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsDataSource productsDataSource;
  ProductsRepositoryImpl({required this.productsDataSource});
  @override
  Future<List<ProductModel>> getListProducts() async {
    try {
      final data = await productsDataSource.getListProducts();
      List<ProductModel> products =
          data.map((element) => ProductModel.fromJson(element)).toList();
      return products;
    } catch (e) {
      return Future.error('Houve um erro ao carregar os dados!');
    }
  }

  @override
  Future<void> deleteProduct(ProductModel product) async {
    try {
      await productsDataSource.deleteProduct(product);
    } catch (e) {
      return Future.error('Não foi possível deletar o produto!');
    }
  }

  @override
  Future<void> editProduct(ProductModel product) async {
    try {
      await productsDataSource.editProduct(product);
    } catch (e) {
      return Future.error('Não foi possível editar o produto!');
    }
  }

  @override
  Future<String> getUrlDownlodStorage(ProductModel product) async {
    try {
      final data = await productsDataSource.getUrlDownlodStorage(product);
      return data;
    } catch (e) {
      return Future.error('Não foi possível baixar a foto');
    }
  }

  @override
  Future<void> uploadImageStorage(
      ProductModel product, String imagePath) async {
    try {
      await productsDataSource.uploadImageStorage(product, imagePath);
    } catch (e) {
      return Future.error('Erro ao fazer upload para o storage!');
    }
  }
}

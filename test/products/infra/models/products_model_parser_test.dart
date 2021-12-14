import 'package:flutter_test/flutter_test.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';

import '../../ui/response_product_model.dart';

void main() {
  Map<String, dynamic> data = product;

  group('product model parser test', () {
    test('must non null product model', () {
      ProductModel productModel = ProductModel.fromJson(data);
      expect(productModel, isNotNull);
      expect(productModel, isA<ProductModel>());
    });

    test('must have none null propriety', () {
      ProductModel productModel = ProductModel.fromJson(data);
      expect(productModel.id, isNull);
      expect(productModel.id, isA<String?>());
      expect(productModel.title, isNotNull);
      expect(productModel.title, isA<String>());
      expect(productModel.description, isNotNull);
      expect(productModel.description, isA<String>());
      expect(productModel.height, isNotNull);
      expect(productModel.height, isA<int>());
      expect(productModel.width, isNotNull);
      expect(productModel.width, isA<int>());
      expect(productModel.rating, isNotNull);
      expect(productModel.rating, isA<int>());
      expect(productModel.price, isNotNull);
      expect(productModel.price, isA<double>());
      expect(productModel.singleName, isNull);
      expect(productModel.singleName, isA<String?>());
    });
  });
}

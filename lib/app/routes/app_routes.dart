import 'package:get/get.dart';
import 'package:project_test/app/products/presenter/bindings/edit_product_bindings.dart';
import 'package:project_test/app/products/presenter/bindings/home_bindings.dart';
import 'package:project_test/app/products/presenter/bindings/initial_bindings.dart';
import 'package:project_test/app/products/ui/edit_product/edit_product_page.dart';
import 'package:project_test/app/products/ui/home/home_page.dart';
import 'package:project_test/app/routes/routes.dart';

class RoutesPages {
  static final routes = [
    GetPage(
        name: Routes.HOME,
        page: () => const HomePage(),
        bindings: [InitialBindings(), HomeBindings()]),
    GetPage(
        name: Routes.EDIT_PRODUCT,
        page: () => EditProductPage(),
        binding: EditProductBindings()),
  ];
}

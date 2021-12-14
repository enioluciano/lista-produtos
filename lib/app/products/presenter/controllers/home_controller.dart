import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';
import 'package:project_test/app/products/presenter/usecases/products_usecase.dart';
import 'package:project_test/app/routes/routes.dart';
import 'package:project_test/app/util/custom_dialogs.dart';

enum Status {
  none,
  empty,
  notEmpty,
  failed,
}

class HomeController extends GetxController {
  final Rx<Status> _status = Status.empty.obs;
  Status get status => _status.value;
  final RxList<ProductModel> _products = <ProductModel>[].obs;
  List<ProductModel> get products => _products;

  Future<void> getLisProduts() async {
    try {
      final data = Get.find<GetProducts>();
      _products.value = await data.call();
      if (products.isEmpty) _status.value = Status.none;
      if (products.isNotEmpty) _status.value = Status.notEmpty;
    } catch (e) {
      _status.value = Status.failed;
      print(e);
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      final data = Get.find<DeleteProduct>();
      await data.call(product);
      Get.back();
      CustomDialog.sucessDialog(text: 'Produto excluído com sucesso!');
      Future.delayed(const Duration(seconds: 3), Get.back);
      getLisProduts();
    } catch (e) {
      Get.back();
      CustomDialog.errorDialog(text: 'Erro ao excluir o item!');
    }
  }

  String textLength(String text) {
    if (text.length <= 30) {
      return text;
    } else {
      String newText = text.substring(0, 31) + "...";
      return newText;
    }
  }

  void navigationEditProduct(ProductModel product) {
    Get.toNamed(Routes.EDIT_PRODUCT, arguments: product);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getLisProduts();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';
import 'package:project_test/app/products/presenter/usecases/products_usecase.dart';
import 'package:project_test/app/routes/routes.dart';
import 'package:project_test/app/util/custom_dialogs.dart';

enum ImageState {
  initialized,
  completed,
  failed,
}

class EditProductController extends GetxController {
  ProductModel? product = ProductModel();
  final Rx<ImageState> _imageState = ImageState.initialized.obs;
  ImageState get imageState => _imageState.value;

  final RxString _image = ''.obs;
  String get image => _image.value;
  void changeImage(String newImage) => _image.value = newImage;

  Future<void> saveProductWithUpload() async {
    product!.updateTime = DateTime.now().millisecondsSinceEpoch;
    try {
      final data = Get.find<UploadImageStorage>();
      await data.call(product!, image);
      Get.back();
      CustomDialog.sucessDialog(text: 'Produto atualizado!');
      Future.delayed(const Duration(seconds: 3), Get.back);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.back();
      CustomDialog.errorDialog(text: 'Erro ao editar o produto!');
    }
  }

  ImagePicker imagePicker = ImagePicker();
  XFile? imageSnapshot;
  Future<void> takeSnapshot() async {
    imageSnapshot = await imagePicker.pickImage(source: ImageSource.camera);
    if (imageSnapshot != null) {
      _image.value = imageSnapshot!.path;
    }
  }

  void removePhoto() {
    _image.value = '';
  }

  Future<void> downloadUrlStorage() async {
    try {
      final data = Get.find<GetUrlDownloadStorage>();
      if (product != null) {
        _image.value = await data(product!);
        _imageState.value = ImageState.completed;
      }
    } catch (e) {
      debugPrint(e.toString());
      _imageState.value = ImageState.failed;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    product = Get.arguments;
    _image.value = product?.url ?? '';
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    downloadUrlStorage();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }
}

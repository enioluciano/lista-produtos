import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_test/app/products/ui/widgets/custom_button.dart';
import 'package:project_test/app/products/ui/widgets/custom_text_form_field.dart';
import 'package:project_test/app/util/custom_dialogs.dart';
import 'package:project_test/app/widgets/shimmer_custom.dart';
import '../../presenter/controllers/edit_product_controller.dart';

class EditProductPage extends GetView<EditProductController> {
  EditProductPage({Key? key}) : super(key: key);
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:
            const Text('Editar Produto', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12), child: _body()),
    );
  }

  Widget _body() {
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          Obx(() => controller.image != '' ? _image() : _noneImage()),
          const SizedBox(height: 20),
          _title(),
          const SizedBox(height: 10),
          _description(),
          const SizedBox(height: 10),
          _type(),
          const SizedBox(height: 10),
          _price(),
          const SizedBox(height: 20),
          _rating(),
          const SizedBox(height: 20),
          _button(),
        ],
      ),
    );
  }

  Widget _image() {
    return Obx(() {
      switch (controller.imageState) {
        case ImageState.initialized:
          return ShimmerCustom.square(height: 140, width: 120);

        case ImageState.completed:
          return _imageCompleted();
        case ImageState.failed:
        default:
          return _imageFailed();
      }
    });
  }

  Widget _imageCompleted() {
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Image.file(File(controller.image),
              height: 140, width: 120, fit: BoxFit.cover),
        ),
        GestureDetector(
          onTap: controller.removePhoto,
          child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              color: const Color.fromRGBO(211, 211, 211, 0.6),
              height: 140,
              width: 120,
              child: const Icon(Icons.delete, color: Colors.red, size: 30)),
        ),
      ],
    );
  }

  Widget _imageFailed() {
    return GestureDetector(
      onTap: controller.removePhoto,
      child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          color: const Color.fromRGBO(211, 211, 211, 0.6),
          height: 140,
          width: 120,
          child: Icon(Icons.error_outline_outlined,
              color: Colors.yellow[700], size: 30)),
    );
  }

  Widget _noneImage() {
    return GestureDetector(
      onTap: controller.takeSnapshot,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        color: const Color.fromRGBO(211, 211, 211, 1),
        height: 140,
        width: 120,
        child: const Icon(Icons.add_a_photo, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _title() {
    return CustomTextFormField(
        initialValue: controller.product?.title,
        hintText: 'Título',
        labelText: 'Título',
        validator: (String? title) {
          if (title!.isEmpty) return 'Campo obrigatório!';
        },
        onSaved: (String? title) {
          controller.product!.title = title;
        });
  }

  Widget _description() {
    return CustomTextFormField(
        initialValue: controller.product?.description,
        hintText: 'Descrição',
        labelText: 'Descrição',
        maxLines: 5,
        onSaved: (String? description) {
          controller.product!.description = description;
        });
  }

  Widget _type() {
    return DropdownButtonFormField<String?>(
        value: controller.product?.type,
        decoration: const InputDecoration(
          hintText: 'Selecione o tipo',
        ),
        validator: (String? type) {
          if (type!.isEmpty) return 'Campo obrigatório!';
        },
        onChanged: (String? type) {},
        onSaved: (String? type) {
          controller.product?.type = type;
        },
        items: ['dairy', 'fruit', 'vegetable', 'bakery', 'meat']
            .map((String type) => DropdownMenuItem(
                  child: Text(type),
                  value: type,
                ))
            .toList());
  }

  Widget _price() {
    return CustomTextFormField(
        initialValue: controller.product?.price.toString(),
        hintText: 'Preço',
        keyboardType: TextInputType.number,
        labelText: 'Preço',
        validator: (String? price) {
          if (price!.isEmpty) return 'Campo obrigatório!';
        },
        prefix: 'R\$ ',
        onSaved: (String? price) {
          double convert = double.parse(price!);
          controller.product!.price = convert;
        });
  }

  Widget _rating() {
    return Align(
      alignment: Alignment.centerLeft,
      child: RatingBar(
        ratingWidget: RatingWidget(
            full: Icon(Icons.star_outlined, color: Colors.yellow[700]),
            half: Icon(Icons.star_half_outlined, color: Colors.yellow[700]),
            empty: Icon(Icons.star_outline, color: Colors.yellow[700])),
        allowHalfRating: false,
        initialRating: controller.product?.rating?.toDouble() ?? 0,
        itemSize: 40,
        onRatingUpdate: (double? rating) {
          controller.product!.rating = rating?.toInt();
        },
      ),
    );
  }

  Widget _button() {
    return Obx(() => CustomButton(
          buttonText: 'Atualizar',
          onPressed: controller.imageState == ImageState.initialized
              ? null
              : () {
                  if (_keyForm.currentState!.validate()) {
                    _keyForm.currentState!.save();
                    CustomDialog.loadDialog(text: 'Atualizando dados...');
                    controller.saveProductWithUpload();
                  }
                },
        ));
  }
}

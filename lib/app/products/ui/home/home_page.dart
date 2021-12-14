import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_test/app/products/infra/models/products_model.dart';
import 'package:project_test/app/products/ui/home/widgets/load_home_page.dart';
import 'package:project_test/app/util/custom_dialogs.dart';
import '../../presenter/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text('Lista de Produtos',
              style: TextStyle(color: Colors.black)),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Obx(() {
            switch (controller.status) {
              case Status.none:
                return Center(
                  child: Text(
                    'Sem produtos no estoque!',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                );
              case Status.empty:
                return const LoadHomePage();
              case Status.notEmpty:
                return ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      ProductModel product = controller.products[index];

                      return _item(product);
                    });

              case Status.failed:
              default:
                return Center(
                  child: Text(
                    'Houve um erro ao carregar os produtos',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                );
            }
          }),
        ),
        bottomNavigationBar: _bottomNavigationBar());
  }

  Widget _item(ProductModel product) {
    return Card(
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image(product),
              const SizedBox(width: 5),
              _description(product),
              const SizedBox(width: 5),
              _icon(product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image(ProductModel product) {
    return CachedNetworkImage(
      height: 100,
      width: 120,
      fit: BoxFit.cover,
      imageUrl: product.url!,
      errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
    );
  }

  Widget _description(ProductModel product) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(product.title!,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(
            controller.textLength(product.description!),
            style: const TextStyle(fontSize: 11),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          _feedback(product),
        ],
      ),
    );
  }

  Widget _feedback(ProductModel product) {
    return RatingBar(
        ratingWidget: RatingWidget(
            full: Icon(Icons.star_outlined, color: Colors.yellow[700]),
            half: Icon(Icons.star_half_outlined, color: Colors.yellow[700]),
            empty: Icon(Icons.star_outline, color: Colors.yellow[700])),
        allowHalfRating: true,
        initialRating: product.rating!.toDouble(),
        itemSize: 20,
        ignoreGestures: true,
        onRatingUpdate: (v) {});
  }

  Widget _icon(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _menuButton(product),
        Text('R\$ ${product.price}',
            style: const TextStyle(fontSize: 14, color: Colors.red))
      ],
    );
  }

  Widget _menuButton(ProductModel product) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      child: Container(
        width: 30,
        alignment: Alignment.centerRight,
        child: const Text('...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      onSelected: (value) {
        if (value == 'Excluir') _dialog(product);
        if (value == 'Editar') controller.navigationEditProduct(product);
      },
      itemBuilder: (BuildContext context) {
        return ['Editar', 'Excluir'].map((String name) {
          return PopupMenuItem(value: name, child: Text(name));
        }).toList();
      },
    );
  }

  Future<void> _dialog(ProductModel product) {
    return CustomDialog.confirmOrRejectDialog(
        title: product.title!,
        onPressed: () {
          Get.back();
          CustomDialog.loadDialog(text: 'Excluindo dados...');
          controller.deleteProduct(product);
        },
        content: [
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: 'Tem certeza que deseja excluir o alimento',
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                  style: const TextStyle(color: Colors.red),
                  text: " ${product.title}"),
              const TextSpan(text: '?', style: TextStyle(color: Colors.black)),
            ]),
          )
        ],
        textConfirm: 'Sim',
        textCancel: 'Não');
  }

  Widget _bottomNavigationBar() {
    return Container(
      height: 60,
      color: Colors.black12,
      child: InkWell(
        onTap: () {},
        child: const Icon(Icons.home, color: Colors.blue, size: 30),
      ),
    );
  }
}

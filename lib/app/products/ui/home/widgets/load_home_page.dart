import 'package:flutter/material.dart';
import 'package:project_test/app/widgets/shimmer_custom.dart';

class LoadHomePage extends StatelessWidget {
  const LoadHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return _item();
        });
  }

  Widget _item() {
    return Card(
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image(),
              const SizedBox(width: 5),
              _description(),
              const SizedBox(width: 5),
              _icon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return ShimmerCustom.square(width: 120, height: 100);
  }

  Widget _description() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerCustom.square(width: 120, height: 14),
          const SizedBox(height: 5),
          ShimmerCustom.square(width: 120, height: 10),
          ShimmerCustom.square(width: 120, height: 10),
          const SizedBox(height: 5),
          _feedback(),
        ],
      ),
    );
  }

  Widget _feedback() {
    return ShimmerCustom.square(width: 90, height: 15);
  }

  Widget _icon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _menuButton(),
        ShimmerCustom.square(width: 40, height: 15),
      ],
    );
  }

  Widget _menuButton() {
    return ShimmerCustom.square(width: 20, height: 10);
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCustom {
  static Widget square({double? width, double? height, double? radius}) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.black12,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(radius ?? 0),
            ),
          )),
    );
  }

  static Widget circle({double? width, double? height}) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.black12,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black26),
          )),
    );
  }

  static Widget card({double? width, double? heightHead}) {
    return Container(
      padding: const EdgeInsets.only(right: 6.0),
      width: width,
      margin: EdgeInsets.only(right: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ShimmerCustom.square(width: width, height: heightHead, radius: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShimmerCustom.square(
                        width: 100, height: 20, radius: 0)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

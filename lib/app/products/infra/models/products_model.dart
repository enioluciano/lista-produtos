import 'package:project_test/app/products/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    String? id,
    String? title,
    String? type,
    String? description,
    String? filename,
    int? updateTime,
    int? height,
    int? width,
    double? price,
    int? rating,
    String? url,
    String? singleName,
  }) : super(
            id: id,
            title: title,
            type: type,
            updateTime: updateTime,
            description: description,
            filename: filename,
            height: height,
            width: width,
            price: price,
            singleName: singleName,
            url: url,
            rating: rating);

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
    filename = json['filename'];
    height = json['height'];
    width = json['width'];
    price = json['price'];
    rating = json['rating'];
    url = json['url'];
    singleName = json['singleName'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['description'] = description;
    data['filename'] = filename;
    data['height'] = height;
    data['width'] = width;
    data['price'] = price;
    data['rating'] = rating;
    data['updateTime'] = updateTime;
    data['singleName'] = singleName;
    data['url'] = url;
    return data;
  }
}

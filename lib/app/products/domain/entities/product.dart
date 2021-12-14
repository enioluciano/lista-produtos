class Product {
  String? id;
  String? title;
  String? type;
  String? description;
  String? filename;
  int? updateTime;
  int? height;
  int? width;
  double? price;
  int? rating;
  String? url;
  String? singleName;

  Product(
      {this.id,
      this.title,
      this.url,
      this.singleName,
      this.type,
      this.updateTime,
      this.description,
      this.filename,
      this.height,
      this.width,
      this.price,
      this.rating});
}

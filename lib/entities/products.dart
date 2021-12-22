class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final int price;
  final String img;

  ProductModel(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.price,
      required this.img});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      price: json['price'],
      img: json['img'],
    );
  }
}

class PhoneModel {
  final int? id;
  final String name;
  final String brand;
  final int price;
  final String img_url;
  final String specification;
  

  PhoneModel({
    this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.img_url,
    required this.specification,
  });

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'],
      img_url: json['img_url'],
      specification: json['specification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id!,
      'name': name,
      'brand': brand,
      'price': price,
      'img_url': img_url,
      'specification': specification,
    };
  }
}
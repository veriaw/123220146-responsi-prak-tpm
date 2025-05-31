class PhoneModel {
  final int id;
  final String name;
  final String brand;
  final int price;
  final String img_url;
  final String spesification;
  

  PhoneModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.img_url,
    required this.spesification,
  });

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      id: json['id'],
      name: json['place_Name'],
      brand: json['brand'],
      price: json['price'],
      img_url: json['pictureUrl'],
      spesification: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'img_url': img_url,
      'spesification': spesification,
    };
  }
}
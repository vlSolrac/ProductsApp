import 'dart:convert';

class Product {
  Product({
    required this.avaliable,
    required this.description,
    required this.name,
    required this.price,
    this.picture,
    this.id,
  });

  bool avaliable;
  String description;
  String name;
  String? picture;
  double price;
  String? id;

  String getUrl() {
    return picture ??
        "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg";
  }

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        avaliable: json["Avaliable"],
        description: json["Description"],
        name: json["Name"],
        picture: json["Picture"],
        price: json["Price"],
      );

  Map<String, dynamic> toMap() => {
        "Avaliable": avaliable,
        "Description": description,
        "Name": name,
        "Picture": picture,
        "Price": price,
      };

  Product copy() => Product(
        avaliable: avaliable,
        description: description,
        name: name,
        price: price,
        picture: picture,
        id: id,
      );
}

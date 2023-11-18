// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.categories,
  });

  List<Category>? categories;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.category,
    this.thumb,
    this.products,
  });

  String? category;
  String? thumb;
  List<Product>? products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    category: json["Category"] == null ? null : json["Category"],
    thumb: json["thumb"] == null ? null : json["thumb"],
    products: json["Products"] == null ? null : List<Product>.from(json["Products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Category": category == null ? null : category,
    "thumb": thumb == null ? null : thumb,
    "Products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.name,
    this.price,
    this.images,
    this.rating,
    this.description,
    this.quantity,
    this.isFavourite,
    this.inCart,
  });

  String? name;
  double? price;
  List<String>? images;
  double? rating;
  String? description;
  String? quantity;
  bool? isFavourite;
  int? inCart;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["Name"] == null ? null : json["Name"],
    price: json["Price"] == null ? null : json["Price"].toDouble(),
    images: json["Images"] == null ? null : List<String>.from(json["Images"].map((x) => x)),
    rating: json["Rating"] == null ? null : json["Rating"].toDouble(),
    description: json["Description"] == null ? null : json["Description"],
    quantity: json["Quantity"] == null ? null : json["Quantity"],
    isFavourite: json["isFavourite"] == null ? null : json["isFavourite"],
    inCart: json["inCart"] == null ? null : json["inCart"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name == null ? null : name,
    "Price": price == null ? null : price,
    "Images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
    "Rating": rating == null ? null : rating,
    "Description": description == null ? null : description,
    "Quantity": quantity == null ? null : quantity,
    "isFavourite": isFavourite == null ? null : isFavourite,
    "inCart": inCart == null ? null : inCart,
  };
}

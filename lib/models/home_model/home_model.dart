class HomeModel{
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel{
  List<BannerModel> banners=[];
  List<ProductsModel>products=[];
  HomeDataModel.fromJson(Map<String,dynamic> json){
    //banners=json['banners'];
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(ProductsModel.fromJson(element));
    });
  //  products=json['products'];
  }
}
class BannerModel{
  int? id;
  String? image;
  BannerModel.fromJson(Map<String,dynamic> json){
    id= json['id'];
    image=json['image'];
  }
}

class ProductsModel{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;
  ProductsModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}







// class HomeModel {
//   bool? status;
//   Null? message;
//   Data? data;
//
//   HomeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<Banners>? banners;
//   List<Products>? products;
//   String? ad;
//
//   Data({this.banners, this.products, this.ad});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['banners'] != null) {
//       banners = <Banners>[];
//       json['banners'].forEach((v) {
//         banners!.add(Banners.fromJson(v));
//       });
//     }
//     if (json['products'] != null) {
//       products = <Products>[];
//       json['products'].forEach((v) {
//         products!.add(Products.fromJson(v));
//       });
//     }
//     ad = json['ad'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (banners != null) {
//       data['banners'] = banners!.map((v) => v.toJson()).toList();
//     }
//     if (products != null) {
//       data['products'] = products!.map((v) => v.toJson()).toList();
//     }
//     data['ad'] = ad;
//     return data;
//   }
// }
//
// class Banners {
//   int? id;
//   String? image;
//   Null? category;
//   Null? product;
//
//   Banners.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     category = json['category'];
//     product = json['product'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['image'] = image;
//     data['category'] = category;
//     data['product'] = product;
//     return data;
//   }
// }
//
// class Products {
//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//   List<String>? images;
//   bool? inFavorites;
//   bool? inCart;
//
//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['price'] = price;
//     data['old_price'] = oldPrice;
//     data['discount'] = discount;
//     data['image'] = image;
//     data['name'] = name;
//     data['description'] = description;
//     data['images'] = images;
//     data['in_favorites'] = inFavorites;
//     data['in_cart'] = inCart;
//     return data;
//   }
// }
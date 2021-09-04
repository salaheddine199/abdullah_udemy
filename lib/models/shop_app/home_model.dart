class HomeModel{
  bool status;
  HomeDataModel data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data'],);
  }
}

class HomeDataModel{

  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String,dynamic> json){

    json['banners'].forEach((e){
      //banners.add(e);
      banners.add(BannerModel.fromJson(e));// this is the correct one I think
    });

    json['products'].forEach((e){
      //products.add(e);
      products.add(ProductModel.fromJson(e)); //this is the correct one I think
    });

  }

}



class BannerModel{

  int id;
  String image;

  BannerModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }

}

class ProductModel{

  int id;
  double price; // these double types he set them dynamic :/
  double oldPrice;
  double discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;

  ProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'].toDouble();
    oldPrice = json['old_price'].toDouble();
    discount = json['discount'].toDouble();
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
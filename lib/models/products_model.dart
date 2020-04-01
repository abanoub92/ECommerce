class ProductsModel {
  
  String name;
  String picture;
  double oldPrice;
  double price;

  ProductsModel({this.name, this.picture, this.oldPrice, this.price});

  String get getName{
    return name;
  }

  String get getPicture{
    return picture;
  }

  double get getOldPrice{
    return oldPrice;
  }

  double get getPrice{
    return price;
  }
  
}
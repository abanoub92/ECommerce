class CartModel {
  
  String name;
  String picture;
  double oldPrice;
  double price;
  int quantity;
  String color;
  String size;

  CartModel({
    this.name, 
    this.picture, 
    this.oldPrice, 
    this.price, 
    this.size, 
    this.quantity,
    this.color
  });

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

  String get getSize{
    return size;
  }

  int get getQuantity{
    return quantity;
  }

  String get getColor{
    return color;
  }
  
}
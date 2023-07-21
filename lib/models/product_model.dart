const String pImage = 'image';
class ProductModel{
  String ? id;
  String ? name;
  num price;
  num saleprice;
  String ? describtion;
  String ? catagory;
  String ? productImage;

  ProductModel(
      {this.id,
      this.name,
      this.price = 0.0,
      this.saleprice = 0.0,
      this.describtion,
      this.catagory,
      this.productImage});

  Map<String,dynamic> toMap (){
    var map =<String,dynamic>{
      'id' : id,
      'name': name,
      'price': price,
      'saleprice': saleprice,
      'catagory':catagory,
      'describtion':describtion,
       pImage:productImage,
    };
    return map;
}
factory ProductModel.formMap(Map<String,dynamic>map) => ProductModel(
  id: map['id'],
 name: map['name'],
  price: map['price'],
  saleprice: map['saleprice'],
  describtion: map['describtion'],
  catagory: map['catagory'],
  productImage: map[pImage],
);

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, price: $price, saleprice: $saleprice, describtion: $describtion, catagory: $catagory, productImage: $productImage}';
  }
}
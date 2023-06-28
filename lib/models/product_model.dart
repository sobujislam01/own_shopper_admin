class ProductModel{
  String ? id;
  String ? name;
  num price;
  String ? describtion;
  String ? catagory;
  String ? productImage;

  ProductModel(
      {this.id,
      this.name,
      this.price = 0.0,
      this.describtion,
      this.catagory,
      this.productImage});

  Map<String,dynamic> toMap (){
    var map =<String,dynamic>{
      'id' : id,
      'name': name,
      'price': price,
      'catagory':catagory,
      'describtion':describtion,
      'image':productImage,
    };
    return map;
}
factory ProductModel.formMap(Map<String,dynamic>map) => ProductModel(
  id: map['id'],
 name: map['name'],
  price: map['price'],
  describtion: map['describtion'],
  catagory: map['catagory'],
  productImage: map['productImage'],
);

}
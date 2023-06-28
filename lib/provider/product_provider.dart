import 'package:flutter/foundation.dart';
import 'package:ownshoppers/db/DB_Helper.dart';
import 'package:ownshoppers/models/product_model.dart';
import 'package:ownshoppers/models/purchase_model.dart';

class ProductProvider extends ChangeNotifier{

  List<ProductModel> productList =[];
  List<PurchaseModel> purchaseList =[];
  List<String> catagoryList = [];

  Future <void> saveProduct(ProductModel productModel,PurchaseModel purchaseModel){
    return DBHelper.addNewProduct(productModel, purchaseModel);
  }
  void getAllCatagory() {
    DBHelper.fetchAllCatagory().listen((event) { 
      catagoryList = List.generate(event.docs.length, (index) => event.docs[index].data()['name']);
      notifyListeners();
    });
  }

  void getAllProduct() {
    DBHelper.fetchAllCatagory().listen((event) {
      productList = List.generate(event.docs.length, (index) => ProductModel.formMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void getAllPurchase() {
    DBHelper.fetchAllCatagory().listen((event) {
      purchaseList = List.generate(event.docs.length, (index) => PurchaseModel.formMap(event.docs[index].data()));
      notifyListeners();
    });
  }
}
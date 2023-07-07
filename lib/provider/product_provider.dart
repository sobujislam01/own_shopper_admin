import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:ownshoppers/db/DB_Helper.dart';
import 'package:ownshoppers/models/product_model.dart';
import 'package:ownshoppers/models/purchase_model.dart';

class ProductProvider extends ChangeNotifier{

  List<ProductModel> productList =[];
  List<PurchaseModel> purchaseList =[];
  List<PurchaseModel> purchaseListOfSpecificProduct =[];
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
    DBHelper.fetchAllProduct().listen((event) {
      productList = List.generate(event.docs.length, (index) => ProductModel.formMap(event.docs[index].data()));
      productList.map((e) => {
        print("id: ${e.id}\n name: ${e.name}\n price:${e.price} \ncatagory: ${e.catagory} sPrice ${e.saleprice}")
      });

      notifyListeners();
    });
  }
  Stream<DocumentSnapshot<Map<String, dynamic>>>getProductByProductId(String productId){
    print(productId);
    return DBHelper.fetchProductbyProductId(productId);
  }

  void getAllPurchase() {
    DBHelper.fetchAllPurchase().listen((event) {
      purchaseList = List.generate(event.docs.length, (index) => PurchaseModel.formMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void getAllPurchaseByProductId(String productId){
    DBHelper.fetchAllPurchaseByProductId(productId).listen((event) {
      purchaseListOfSpecificProduct = List.generate(event.docs.length, (index) => PurchaseModel.formMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  Future<void> uploadImage(File imageFile,String productId,String productName)async{
    final rootRef = FirebaseStorage.instance.ref();
    final imageRef = rootRef.child('$productName {$productName}_${DateTime.now().microsecondsSinceEpoch}');
    final uploadTask = imageRef.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {
      
    }).catchError((error){

    });
    print(snapshot);
    final url = await snapshot.ref.getDownloadURL();
    await updateImageUrl(url, productId);
  }

  Future<void> updateImageUrl(String url,String productId){
    return DBHelper.updateImageUrl(url, productId);
  }
}
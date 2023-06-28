import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ownshoppers/models/product_model.dart';
import 'package:ownshoppers/models/purchase_model.dart';

class DBHelper {
  static const _collectionProduct = 'products';
  static const _collectionCategory = 'catagory';
  static const _collectionPurchase = 'purchase';

  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addNewProduct(ProductModel productModel,PurchaseModel purchaseModel){
    final writeBatch = _db.batch();
    final productDoc = _db.collection(_collectionProduct).doc();
    final purchaseDoc = _db.collection(_collectionPurchase).doc();
    productModel.id = productDoc.id;
    purchaseModel.productId = productDoc.id;
    purchaseModel.purchaseId = productDoc.id;


    writeBatch.set(productDoc, productModel.toMap());
    writeBatch.set(purchaseDoc, purchaseModel.toMap());

    return writeBatch.commit();
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllCatagory() =>
      _db.collection(_collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllProduct() =>
      _db.collection(_collectionProduct).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllPurchase() =>
      _db.collection(_collectionPurchase).snapshots();


}